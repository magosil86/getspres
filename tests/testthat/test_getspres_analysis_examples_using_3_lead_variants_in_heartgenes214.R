### library(getspres); library(testthat); Sys.setenv(NOT_CRAN="true")

### see also:
###     https://magosil86.github.io/getspres/
###
###     Magosi LE, Goel A, Hopewell JC, Farrall M, on behalf of the CARDIoGRAMplusC4D Consortium (2018) 
###     Identifying small-effect genetic associations overlooked by the conventional fixed-effect model 
###     in a large-scale meta-analysis of coronary artery disease. 
###     To submit for publication.


context("Checking getspres example: Calculate SPRE statistics for 3 variants in the heartgenes214 dataset ")


test_that("correct SPRE statistics are calculated.", {


	### Test may take longer than 1 min hence test will be run locally rather than on CRAN
	skip_on_cran()

	### Load libraries

	   
	### Load heartgenes214 dataset
	### ?heartgenes214 to view the dataset documentation
	data(heartgenes214, package="getspres")


	### Calculating SPRE statistics for 3 variants in heartgenes214

	### Note: Would have liked to calculate SPRE statistics and generate forest plots 
	###       for variants: "rs16856093", "rs10890302" and "rs10139550" as they were 
	###       presented as figures 3 - 5 in the manuscript draft referred to above. 
	###       However, only "rs10139550" has data available in heartgenes214 hence 
	###       selected two other variants ("rs10168194" and "rs11191416") as examples.

	heartgenes3 <- subset(heartgenes214, 
		variants %in% c("rs10139550", "rs10168194", "rs11191416"))
		
	getspres_results <- getspres(beta_in = heartgenes3$beta_flipped, 
								   se_in = heartgenes3$gcse, 
						  study_names_in = heartgenes3$studies, 
						variant_names_in = heartgenes3$variants)


	### Retrieve number of studies and variants
	num_variants <- getspres_results$number_variants
	num_studies <- getspres_results$number_studies

	### Retrieve SPRE dataset
	df_spres <- getspres_results$spre_dataset


	### checking number of studies and variants
	expect_equal(num_variants, 3)
	expect_equal(num_studies, 48)

	### checking SPRE statistic values for studies 1 - 6 at each of the 3 variants
	expect_equal(round(subset(df_spres[, c("spre")], df_spres$variant_names %in% "rs10168194" & as.numeric(df_spres$study) <= 6), 4), round(c(-0.8196669, -0.2689183, -0.4217485, 0.7116014, -0.6176853, 0.4814332), 4))
	expect_equal(round(subset(df_spres[, c("spre")], df_spres$variant_names %in% "rs10139550" & as.numeric(df_spres$study) <= 6), 4), round(c(-1.7838806, 0.4767771, 0.2405504, 0.8596358, 2.2172400, 1.0915446), 4))
	expect_equal(round(subset(df_spres[, c("spre")], df_spres$variant_names %in% "rs11191416" & as.numeric(df_spres$study) <= 6), 4), round(c(1.0164801, -0.7228475, -0.1810490, 1.7472015, -0.3073316, -0.5469473), 4))


	### Generating a forest plot for variant: "rs10139550" in heartgenes214.
	
	df_rs10139550 <- subset(df_spres, variant_names == "rs10139550")
	
	plotspres_res <- plotspres(beta_in = df_rs10139550$beta, 
								 se_in = df_rs10139550$se, 
						study_names_in = as.character(df_rs10139550$study_names), 
					  variant_names_in = as.character(df_rs10139550$variant_names),
							  spres_in = df_rs10139550$spre,
				   spre_colour_palette = c("multi_colour", "rainbow"),
			  set_studyNOs_as_studyIDs = TRUE,
							  set_xlim = c(-8,8), set_ylim = c(-1.5,51),
								set_at = c(-3.0, -2.5, -2.0, -1.5, -1.0, -0.5, 0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0),
							 save_plot = TRUE)

	### Note: Forest plot for "rs10139550" should resemble figure 5 in the manuscript draft referred to above.


	# Adjust label (i.e. column header) position, also keep plot in graphics window rather
	#     than save as tiff file
	df_rs10139550_3studies <- subset(df_rs10139550, as.numeric(df_rs10139550$study_names) <= 3)

	# Before adjusting label positions
	plotspres_res <- plotspres(beta_in = df_rs10139550_3studies$beta, 
								 se_in = df_rs10139550_3studies$se, 
						study_names_in = as.character(df_rs10139550_3studies$study_names), 
					  variant_names_in = as.character(df_rs10139550_3studies$variant_names),
							  spres_in = df_rs10139550_3studies$spre,
				   spre_colour_palette = c("dual_colour", c("blue","black")),
							 save_plot = FALSE)

	### Note: Forest plot for "rs10139550" should comprise 3 studies.

	# After adjusting label positions
	plotspres_res <- plotspres(beta_in = df_rs10139550_3studies$beta, 
								 se_in = df_rs10139550_3studies$se, 
						study_names_in = as.character(df_rs10139550_3studies$study_names), 
					  variant_names_in = as.character(df_rs10139550_3studies$variant_names),
							  spres_in = df_rs10139550_3studies$spre,
				   spre_colour_palette = c("dual_colour", c("blue","black")),
						 adjust_labels = 1.7, save_plot = FALSE)

	### Note: After adjusting label positions, column headers in the "rs10139550" forest plot 
	###       should now be 2 rows lower.

})
