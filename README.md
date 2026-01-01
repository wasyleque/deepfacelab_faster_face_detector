# DeepFaceLab Enhancement Scripts

This package provides a set of scripts and modifications to enhance the standard [DeepFaceLab](https://github.com/iperov/DeepFaceLab) workflow, particularly for Linux users utilizing the [DeepFaceLab_Linux](https://github.com/nagadit/DeepFaceLab_Linux) fork.

These enhancements offer:
1.  **A new, high-performance face extraction pipeline** using modern, lightweight ONNX models (`UltraFace` for detection and `PFLD` for landmark extraction).
2.  **A fully automated merge process** that runs non-interactively based on a pre-configured set of options.
3.  **Two automated merge modes**: A "Quality" mode using the original `seamless` blending and a "FAST" mode using a much faster `overlay` blending with mask blurring.

## Original Projects

A huge credit goes to the original creators of DeepFaceLab.
*   **Main DeepFaceLab repo:** [https://github.com/iperov/DeepFaceLab](https://github.com/iperov/DeepFaceLab)
*   **Linux Fork:** [https://github.com/nagadit/DeepFaceLab_Linux](https://github.com/nagadit/DeepFaceLab_Linux)

---

## 1. Installation & Setup

### Prerequisites

- A working installation of DeepFaceLab, preferably the Linux fork mentioned above.
- A configured `deepfacelab` conda environment.

### Step 1: Install Python Requirements

The new extraction script requires a few Python libraries. Install them into your `deepfacelab` conda environment using the provided file.

```bash
# Activate your conda environment first
conda activate deepfacelab

# Install the packages
pip install -r requirements.txt
```

### Step 2: Place the New Scripts and Models

Copy the contents of the `scripts` directory from this package into the `scripts` directory of your main `DeepFaceLab_Linux` installation.

```bash
# From the root of your DeepFaceLab_Linux project
cp -r xxxx/scripts/* scripts/
```
This will add the new extractor, models, and shell scripts to your project.

### Step 3: Patch the Original Merger Script

To enable the automated merging functionality, you need to apply a small patch to the original `Merger.py` script.

1.  Navigate to the root directory of your `DeepFaceLab_Linux` project.
2.  Apply the patch using the following command:

```bash
patch DeepFaceLab/mainscripts/Merger.py < dfl_merger_mods.patch
```

This command modifies `Merger.py` to allow it to be controlled by an environment variable for automated runs. A backup of the original file (`Merger.py.bak`) was created in the same directory when you first ran the agent's command.

---

## 2. Usage

### Faster Face Extraction

Instead of using the standard `4_...` or `5_...` S3FD extraction scripts, use the new UltraFace script. It is generally faster and produces fully compatible DFL JPG files with all the necessary metadata.

```bash
./scripts/5_data_dst_extract_faces_UltraFace.sh
```

### Automated Merging

You now have two new automated scripts for merging. Run them from the root of your project. They will start immediately without asking for interactive input.

**Option 1: Automated QUALITY Mode**

This uses your preferred high-quality settings with the slow `seamless` blending method.

```bash
./scripts/7_merge_SAEHD_automated.sh
```

**Option 2: Automated FAST Mode**

This uses a much faster `overlay` blending method with mask blurring to produce similar (but not identical) results in a fraction of the time. This is ideal for quick previews.

```bash
./scripts/7_merge_SAEHD_automated_FAST.sh
```
