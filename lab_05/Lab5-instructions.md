# 🧪 Lab 5 – Java, apt vs apt-get, Snap, GUI, Vim on Ubuntu Server

**Estimated Duration:** ~3 hours  
**Repository Name:** `CC_<YourName>_<YourRollNumber>` → `Lab5` folder inside it.      
**Lab5 Report Link:** [Open Lab5 Report](https://raw.githubusercontent.com/hajrasarwar11/CC-HajraSarwar-022/main/lab5/Lab5-Report.pdf)






---

## 🎯 Objective

This lab explores package management, GUI installation, and Vim editing on Ubuntu Server:

- Discover system suggestions when commands are missing (e.g., `java`).
- Install/remove packages using `apt` and `apt-get`.
- Understand `apt update` vs `apt upgrade`.
- Install CLI and GUI applications via Snap and PPAs.
- Install lightweight GUI (XFCE) + XRDP and manage GUI boot/login.
- Launch and verify GUI apps (Visual Studio Code).
- Use Vim for creating/editing Kubernetes YAML manifests.
- Practice Vim commands: search, substitute, undo, navigation.

By the end, you’ll confidently manage packages, work with Vim, and handle basic GUI operations on a headless server.

---

## 🧩 Prerequisites

- Ubuntu Server VM (Lab 4 VM is fine).
- SSH access and sudo privileges.
- Adequate VM resources for GUI apps.
- Basic knowledge of Linux terminal and commands.

---

<details>
<summary>📋 Task Overview & Notes (Click to expand)</summary>

### **Task 1 – Discover missing command & install Java**
- Run `java` to see system suggestions.
- Install suggested package using `apt`.
- Verify, remove, and clear shell cache with `hash -r`.
- **Errors faced:** Sometimes system suggests multiple Java packages; ensure you pick the one suggested for your VM.

**Screenshots Required:**
`task1_java_suggestion.png`, `task1_java_install.png`, `task1_java_version.png`, `task1_java_remove.png`, `task1_java_not_found.png`, `task1_hash_clear.png`

---

### **Task 2 – Install & remove Java via apt-get**
- Repeat Task 1 using `apt-get`.
- Clear shell cache and verify removal.
- **Tip:** Use the same package name as Task 1 to avoid leftover files.

**Screenshots:**
`task2_aptget_install.png`, `task2_java_version_after_aptget.png`, `task2_aptget_remove.png`, `task2_hash_after_remove.png`

---

### **Task 3 – apt update vs apt upgrade**
- `sudo apt update` → refreshes package index.
- `sudo apt upgrade` → upgrades installed packages.
- Write a brief explanation (~3–5 sentences).
- **Common issue:** Forgetting to run `apt update` before upgrade may lead to outdated packages.

**Screenshots:**
`task3_apt_update.png`, `task3_apt_upgrade.png`, `task3_explanation.png`

---

### **Task 4 – Install VS Code via Snap**
- Install VS Code using Snap.
- Verify installation from CLI.
- **Tip:** Keep Code installed for Tasks 5 & 6.

**Screenshots:**
`task4_snap_install.png`, `task4_snap_list.png`, `task4_code_version_or_info.png`, `task4_snap_bin_location.png`

---

### **Task 5 – Install XFCE GUI + XRDP & launch VS Code**
- Install lightweight GUI (XFCE), XRDP for remote access.
- Launch VS Code in GUI to verify visual operation.
- **Common errors:** GUI may fail to start without `~/.xsession`. XRDP login issues may require session cleanup.

**Screenshots:**
`task5_update.png`, `task5_xfce_install.png`, `task5_xrdp_enable.png`, `task5_xrdp_status.png`, `task5_xsession.png`, `task5_rdp_connect.png`, `task5_vscode_launch.png`

---

### **Task 6 – LightDM greeter & GUI verification**
- Install `lightdm-gtk-greeter` to fix login issues.
- Enable/disable GUI boot targets and test behavior.
- Launch VS Code in GUI and capture screenshots.
- **Tip:** Always reboot after changing boot targets to verify results.

**Screenshots:**
`task6_lightdm_install.png`, `task6_lightdm_config.png`, `task6_lightdm_cleanup.png`, `task6_lightdm_restart.png`, `task6_gui_enable_boot.png`, `task6_after_reboot_gui.png`, `task6_gui_disable_boot.png`, `task6_after_reboot_cli.png`, `task6_gui_start.png`, `task6_gui_stop.png`, `task6_gui_start_command.png`, `task6_vscode_launch.png`

---

### **Task 7 – Install Google Chrome via apt source & key**
- Attempt direct install → fail → add repo & key → install.
- Alternative preferred method: single-line `.list` entry.
- **Common errors:** Missing `/etc/apt/keyrings` or incorrect key permissions.

**Screenshots:**
`task7_install_chrome_error.png`, `task7_ls_etc_apt.png`, `task7_cat_sources_list.png`, `task7_ls_sources_list_d.png`, `task7_cat_ubuntu_sources.png`, `task7_edit_ubuntu_sources.png`, `task7_add_key.png`, `task7_apt_update.png`, `task7_install_chrome.png`, `task7_alternate_remove.png`, `task7_alternate_edit.png`, `task7_remove_key.png`, `task7_create_google_chrome_list.png`, `task7_list_sources_after_create.png`, `task7_add_key_alt.png`, `task7_apt_update_alt.png`, `task7_install_chrome_alt.png`

---

### **Task 8 – Install applications via PPA (Audacity & OBS)**
- Add PPAs, install, and launch apps.
- Verify installation on headless servers via CLI if GUI not available.
- **Common issues:** Some PPAs fail if system packages are outdated; run `sudo apt update` after adding PPA.

**Screenshots:**
`task8_add_ppa_audacity.png`, `task8_apt_update_audacity.png`, `task8_install_audacity.png`, `task8_audacity_launch.png`, `task8_add_ppa_obs.png`, `task8_apt_update_obs.png`, `task8_install_obs.png`, `task8_obs_launch.png`

---

### **Task 9 – Create Kubernetes YAML using Vim**
- Confirm Vim availability; create `~/Lab5/k8s-sample.yaml`.
- Save the file using `:wq`.
- **Errors faced:** Vim not installed initially; resolved with `sudo apt install vim`.

**Screenshots:**
`task9_vim_check.png`, `task9_vim_install.png`, `task9_mkdir_cd.png`, `task9_vim_edit.png`, `task9_k8s_saved.png`

---

### **Task 10 – Edit YAML & discard temporary changes**
- Add annotation permanently, verify, then make temporary edit & discard.
- **Tip:** YAML is indentation-sensitive; use spaces carefully.

**Screenshots:**
`task10_verify_annotation.png`, `task10_verify_entering_temp_data.png`, `task10_verify_no_temp_comment.png`

---

### **Task 11 – Vim editing practice**
- Delete lines (`dd`, `d3d`), undo (`u`), navigate (`1G`, `G`, `$`, `0`).
- Capture before/after screenshots.
- **Common errors:** Accidental save → restore file before capturing evidence.

**Screenshots:**
`task11_dd_delete_and_undo.png`, `task11_delete3_and_undo.png`, `task11_line1.png`, `task11_navigation.png`

---

### **Task 12 – Vim search, add matches, substitute, undo**
- Search `/pattern`, navigate `n/N`, add occurrences, substitute `:%s/old/new`, undo `u`.
- **Tip:** If substitution saved accidentally, reopen file to restore content before screenshot.

**Screenshots:**
`task12_search_nginx.png`, `task12_n_and_N_navigation.png`, `task12_added_occurrences.png`, `task12_cycle_matches.png`, `task12_substitute_result.png`, `task12_undo_and_quit.png`

---

### **Exam Evaluation Task – Docker Desktop**
- Install Docker Desktop on the VM, verify installation.
- **Important:** No commands provided; self-research required.

**Screenshot:**
`exam_evaluation_docker_desktop.png`

</details>

---

## ⚠️ Troubleshooting & Notes

- **Package install errors:** Usually network-related or missing keys; capture outputs.  
- **Vim issues:** Remember `i` (insert), `Esc` (command), `:wq` (save & quit), `:q!` (quit without saving).  
- **GUI launch issues:** Ensure `.xsession` and LightDM config correct; reboot to verify boot targets.  
- **Snap packages:** Ensure `--classic` option for VS Code.  
- **PPAs & Chrome:** Ensure `/etc/apt/keyrings` exists; proper permissions required.

---

## 📂 Submission

Repository structure:

```
CC_<YourName>_<YourRollNumber>/
└─ Lab5/
   ├─ workspace/          # optional sample files
   ├─ screenshots/        # all screenshots captured above
   ├─ Lab5-instructions.md # this file
   └─ Lab5.md or PDF      # optional Word/PDF with screenshots and answers
```

**Checklist:**
- Completed all 12 tasks + Exam Evaluation.
- Screenshots for each step saved as named above.
- Repo pushed to GitHub.


