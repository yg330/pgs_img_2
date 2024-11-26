#!/bin/bash
#SBATCH -A WARRIER-SL2-CPU
#SBATCH -J YG_GWAS
#SBATCH -D /rds/user/yg330/rds-genetics_hpc-Nl99R8pHODQ/UKB/Imaging_genetics/yg330
#SBATCH -o /rds/user/yg330/hpc-work/pgs_img_2/SSHscript/GWAS_log/regional_SubCorVol_GWAS_25112024.log
#SBATCH -e /rds/user/yg330/hpc-work/pgs_img_2/SSHscript/GWAS_log/regional_SubCorVol_GWAS_25112024.err
#SBATCH -p sapphire
#SBATCH -t 12:00:00
#SBATCH --mem=100G
#SBATCH --mail-type=ALL

# Load modules
. /etc/profile.d/modules.sh                                # Leave this line (enables the module command)
module purge
module load rhel8/default-ccl
module load ceuadmin/gcta/1.94.1

# Loop to execute GWAS 26 times per array task

for i in {1..26}; do
  gcta --fastGWA-mlm \
       --mbfile ./script/GWAS_mbfile.txt \
       --grm-sparse ./GRM/sp0.05_autosome_grm \
       --pheno /rds/user/yg330/hpc-work/pgs_img_2/result_supplement/imaging_data_final/subcor_vol.sd.mad.QCed.txt \
       --mpheno $i \
       --qcovar ./MRI_GWAS_COVAR/continous.COVAR.formatted.txt \
       --covar ./MRI_GWAS_COVAR/structural.discrete.COVAR.formatted.txt \
       --out ./MRI_Regional_GWAS/SubCorVol/25112024_mad.GWAS_STR_regional_SubCorVol_pheno"$i"
done

