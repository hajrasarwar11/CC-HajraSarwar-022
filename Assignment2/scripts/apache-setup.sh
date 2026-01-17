#!/bin/bash
set -e

# -------------------- Update system --------------------
yum update -y

# -------------------- Install Apache --------------------
yum install httpd -y

# -------------------- Start & enable Apache --------------------
systemctl start httpd
systemctl enable httpd

# -------------------- Get IMDSv2 token --------------------
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# -------------------- Fetch metadata --------------------
PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)

PUBLIC_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/public-ipv4)

PUBLIC_DNS=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/public-hostname)

INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

HOSTNAME=$(hostname)

# -------------------- Detect server role --------------------
if [[ "$HOSTNAME" == *"web-1"* ]]; then
  SERVER_ROLE="Primary"
elif [[ "$HOSTNAME" == *"web-2"* ]]; then
  SERVER_ROLE="Primary"
else
  SERVER_ROLE="Backup"
fi

# -------------------- Create custom HTML --------------------
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Backend Web Server</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            background: rgba(255,255,255,0.15);
            padding: 30px;
            border-radius: 10px;
        }
        .info {
            margin: 10px 0;
            padding: 10px;
            background: rgba(255,255,255,0.2);
            border-radius: 5px;
        }
        .label { font-weight: bold; color: #ffd700; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Backend Server - Assignment 2</h1>
        <div class="info"><span class="label">Hostname:</span> $HOSTNAME</div>
        <div class="info"><span class="label">Instance ID:</span> $INSTANCE_ID</div>
        <div class="info"><span class="label">Private IP:</span> $PRIVATE_IP</div>
        <div class="info"><span class="label">Public IP:</span> $PUBLIC_IP</div>
        <div class="info"><span class="label">Public DNS:</span> $PUBLIC_DNS</div>
        <div class="info"><span class="label">Server Role:</span> $SERVER_ROLE</div>
        <div class="info"><span class="label">Deployed At:</span> $(date)</div>
        <div class="info"><span class="label">Status:</span> ✅ Running</div>
    </div>
</body>
</html>
EOF

# -------------------- Permissions --------------------
chmod 644 /var/www/html/index.html

echo "Apache backend setup completed successfully"
