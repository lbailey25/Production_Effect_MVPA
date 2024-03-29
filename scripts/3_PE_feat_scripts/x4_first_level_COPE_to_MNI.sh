#!/bin/bash

# The purpose of this script is to transform COPE images (generated by LSA) to
#  MNI space, independently for each subject.

# Define top_dir
top_dir=$(<../top_dir_linux.txt)

# Define list of subjects
subjects=(subject-002 subject-003 subject-004 subject-005 subject-006 subject-007 subject-008
          subject-009 subject-010 subject-011 subject-012 subject-013 subject-014 subject-015
          subject-016 subject-017 subject-018 subject-019 subject-020 subject-021 subject-022
          subject-023 subject-024 subject-025 subject-026 subject-027 subject-028 subject-029
          subject-030)

# Define important directories
top_dir=/media/lyam/Production_Effect_MVPA/
data_dir=${top_dir}/MRIanalyses/PE/subject_level_output/
assets_dir=${top_dir}/MRIanalyses/assets

# Define path to MNI template
standard_fn=/usr/local/fsl/data/standard/MNI152_T1_2mm_brain
standard_head_fn=/usr/local/fsl/data/standard/MNI152_T1_2mm

# Define runs
runs=(study_1 study_2 test)

# Loop through subjects
for subject in ${subjects[@]}; do

  echo ${subject}

  # Define path to highres structural images for this subject
  highres_fn=${top_dir}/MRIdata/${subject}/${subject}_struct_brain
  highres_head_fn=${top_dir}/MRIdata/${subject}/${subject}_struct

  # Define output directory for this subject
  output_dir=${data_dir}/${subject}/firstLevelCOPEs2MNI
  mkdir -p ${output_dir}

  # Loop through runs. On each loop, we will apply an affine example_func2standard
  # transform to each COPE in the run. These transforms have already been generated
  # during first-level FEAT
   for run in ${runs[@]}; do

    # Define path to example_func2standard for this run
    # (stored in the feat/reg folder for this run)
    feat_dir=${data_dir}/${subject}/${subject}_${run}_LSA.feat
    reg_dir=${feat_dir}/reg

    example_func2standard=${reg_dir}/example_func2standard

    # --------------------------------------------------------------------------
    # If we wanted to use nonlinear transform, we would first compute
    # highres2standard_warp transform, and then combine it with existing
    # linear transforms. See below
    # --------------------------------------------------------------------------

    # highres2standard=${reg_dir}/highres2standard
    # example_func2highres=${reg_dir}/example_func2highres

    # # We'll put the nonlinear transforms in a seperate folder in the feat dir,
    # # to differentaite them from regular feat output
    # transform_output_dir=${feat_dir}/computed_nonlinear_transforms/${run}
    # mkdir -p ${transform_output_dir}
    # highres2standard_warp_fn=${transform_output_dir}/highres2standard_warp

    # # Compute the highres2standard_warp transform, using linear transforms generated by FEAT
    # # This takes a long time, so skip if the file already exists
    # if [ ! -f ${highres2standard_warp_fn} ]; then
    #   fnirt --in=${highres_head_fn} --ref=${standard_head_fn} \
    #         --aff=${highres2standard}.mat \
    #         --cout=${highres2standard_warp_fn} \
    #         --config=/usr/local/fsl/etc/flirtsch/T1_2_MNI152_2mm.cnf
    # fi

    # In the COPE loop below, we would apply the nonlinear transform wih:

    # applywarp --in=${cope_fn} --ref=${standard_head_fn} --warp=${highres2standard_warp_fn} \
    #           --premat=${example_func2highres}.mat --out=${cope_output_fn}
    # --------------------------------------------------------------------------

    # Define list of COPEs for this run
    copes=$(ls ${feat_dir}/stats/cope*)

    # Loop through COPEs, applying the affine transform to each
    for cope_fn in ${copes}; do

      # Define output filenames
      cope_label=$(basename ${cope_fn})
      cope_output_fn=${output_dir}/${run}_${cope_label}

      # Apply transform to this COPE
      flirt -in ${cope_fn} -ref ${standard_fn} -applyxfm -init ${example_func2standard}.mat -out ${cope_output_fn}

    done # copes
  done # runs
done # subjects
