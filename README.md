# Project description 
This GitHub repository contains code used for an fMRI study of the production effect, conducted at Dalhousie University between November 2021 and March 2022. This code is intended to be used in conjunction with data and assets from the same study, stored in [a companion OSF repository][1]. If you download all the data (stored on OSF) and all the scripts (stored here), and arrange the folders into the directory structure described below, you should be able to run all the analyses as intended.

This study involved two experiments, which were dubbed _PE_ and _quickread_ respectively. PE is short for "production effect"; this experiment was a modified version of the paradigm from [Bailey et al. (2021)][2], specifically intended for multivariate analysis. The quickread experiment was a shortened version of the study phase from the PE experiment with more rapid trial presentation. These two experiments are related; however, data from each has been analyzed and written up independently. At present, we have performed RSA (representational similarity analysis) on the quickread data, the results of which are reported in [this preprint][3]. We have performed PaSTA (pattern similarity and transformation analyses) on the PE data, results reported in [this preprint][4].

# Directory structure
This project uses the following directory structure. All folders described below should be downloaded (either from this repo or from OSF) and placed within a single directory.

`scripts`: Contains all scripts for data preprocessing and analysis. More detail is provided in the README within the scripts folder. **This folder is included in this repository.** 

`MRIdata`: Contains preprocessed fMRI data (4D functional images from each experiment) and brain-extracted T1 images from twelve subjects who consented to their anonymized data being made publicly accessible. **This folder is included in the OSF repository.** 

`MRIanalyses`: Contains all assets required for the analysis scripts stored in `scripts`. This folder also serves as the main output folder for said scripts. Assets are auxiliary files that are necessary for data analysis, but are not derived directly from the MRI data themselves. Examples of assets include fMRI log files, MNI templates, corpora, and the like. Assets are stored in subject-specific subfolders, which in turn contain assets required for both the PE and quickread pipelines. Some assets are provided in the OSF repo, but where possible they are generated as part of the analysis pipeline. If you notice that any assets are missing, contact lyam.bailey@dal.ca or aaron.newman@dal.ca. **This folder is included in the OSF repository.**

`behavioural_data`: Contains raw behavioural data acquired during fMRI scanning, from twelve subjects who consented to their anonymized data being made publicly accessible. Note that the subfolders `fMRI_runs1` and `fMRI_runs2` pertain to the PE and quickread experiments respectively. **This folder is included in the OSF repository.**

[1]: https://osf.io/czb26/?view_only=86a66caf1d71484d8ef0293cfa2371df
[2]: https://doi.org/10.1016/j.bandc.2021.105757
[3]: https://www.biorxiv.org/content/10.1101/2024.02.18.580744v1
[4]: https://biorxiv.org/cgi/content/short/2024.02.20.581164v1
