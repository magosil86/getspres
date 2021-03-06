# Goal: Generate and export S3 class/methods for plotspres and document using roxygen tags
#
#' \code{plotspres} generates forest plots showing \emph{SPRE} statistics.
#'
#'
#' Forest plots showing \emph{SPRE} (standardised predicted random-effects) statistics 
#' can be useful in highlighting overly influential outlier studies with the potential
#' to inflate summary effect estimates in genetic association meta-analyses.
#'
#' \code{plotspres} takes as input \emph{SPRE} statistics, observed study effects 
#' and corresponding standard errors (i.e. summary data). The observed study effects 
#' (i.e. study effect-size estimates) could be association statistics from either 
#' quantitative or binary trait meta-analyses, for instance, linear regression coefficients 
#' might be employed for quantitative traits and log-transformed logistic regression 
#' coefficients (per-allele log odds ratios) used for case-control meta-analyses. 
#' \emph{SPRE} statistics can be calculated using the \code{\link{getspres}} function.
#'
#' \code{plotspres} uses inverse-variance weighted fixed and random-effects 
#'  meta-analysis models in the \code{metafor} R package to generate forestplots.
#' 
#' @seealso \code{\link{getspres}} to calculate \emph{SPRE} statistics and the 
#' \code{\link[metafor:rma.uni]{metafor}} package to explore implementations of fixed and 
#' random-effects meta-analysis models in R. To access more information and examples 
#' visit the getspres website at: \url{https://magosil86.github.io/getspres/}.
#'
#'
#' @aliases plotspres plotspre forestspre spreforest
#'
#' @param beta_in                  A numeric vector of observed study effects e.g. log odds-ratios.
#' @param se_in                    A numeric vector of standard errors, genomically corrected at study-level.
#' @param study_names_in           A character vector of study names.
#' @param variant_names_in         A character vector of variant names e.g. rsIDs.
#' @param spres_in                 A numeric vector of \emph{SPRE} statistics.
#' @param spre_colour_palette      An optional character vector specifying the colour palette that should be used for observed study effects. There are 3 types of colour palettes available, namely: "mono_colour", "dual_colour" and "multi_colour"; with the "dual_colour" palette, observed study effects with negative \emph{SPRE} statistics are coloured differently from those with positive \emph{SPRE} statistics, and with the "multi_colour" palette observed study effects are colored in a gradient according to the \emph{SPRE} statistic values. Default palette option is \code{spre_colour_palette = c("mono_colour", "black")}. 
#' @param set_studyNOs_as_studyIDs An optional boolean specifying whether study numbers should be used as study IDs in the forest plot. Default is \code{FALSE}. 
#' @param set_study_field_width    An optional character vector of format strings, akin to the fmt character vector in the sprintf function. (Default is \code{set_study_field_width = "\%02.0f"}).
#' @param set_cex                  An optional character scalar and symbol expansion factor indicating the percentage by which text and symbols should be scaled relative to the reference; e.g. 1=reference, 1.3 is 30\% larger, 0.3 is 30\% smaller. (Default is \code{cex = 0.66}).
#' @param set_xlim                 An optional numeric vector of length 2 indicating the horizontal limits of the plot region.
#' @param set_ylim                 An optional numeric vector of length 2 indicating the y-axis limits of the plot.
#' @param set_at                   An optional numeric vector indicating position of the x-axis tick marks and corresponding labels.
#' @param tau2_method              An optional character scalar, specifying the method that should be used to estimate heterogeneity either through DerSimonian and Laird's moment-based estimate "DL" or restricted maximum likelihood "REML". Note: The REML method uses the iterative Fisher scoring algorithm (step length = 0.5, maximum iterations = 10000) to estimate tau2. Default is "DL".
#' @param adjust_labels            An optional numeric scalar value that tweaks label (column header) positions. (Default is \code{adjust_labels = 1}).
#' @param save_plot                An optional boolean to save forestplot as a tiff file. Default is \code{TRUE}.
#' @param verbose_output           An optional boolean to display intermediate output. (Default is \code{FALSE}).
#' @param \dots other arguments.
#'         
#' @return Returns a list containing:
#' \itemize{
#'   \item number_variants         A numeric scalar indicating the number of variants 
#'   \item number_studies          A numeric scalar indicating the number of studies
#'   \item fixed_effect_results    A list of fixed-effect meta-analysis results for each variant examined
#'   \item random_effects_results  A list of random-effects meta-analysis results for each variant examined
#'   \item spre_forestplot_dataset A dataframe of the data provided by the user for analysis which contains the following fields:
#'   \itemize{
#'         \item beta            , study effect-size estimates
#'         \item se              , corresponding standard errors of study effect-size estimates
#'         \item variant_names   , variant names
#'         \item study_names     , study names
#'         \item spre            , \emph{SPRE} (standardised predicted random-effects) statistics
#'         \item study_numbers   , study numbers
#'         \item variant_numbers , variant numbers
#'         }
#' }
#'
#' @examples
#' library(getspres)
#'
#' 
#' # Generate a forest plot showing SPRE statistics for variants in heartgenes214.
#' # heartgenes214 is a case-control GWAS meta-analysis of coronary artery disease.
#' # To learn more about the heartgenes214 dataset ?heartgenes214
#'
#' # Calculating SPRE statistics for 3 variants in heartgenes214
#'
#' heartgenes3 <- subset(heartgenes214, 
#'     variants %in% c("rs10139550", "rs10168194", "rs11191416")) 
#'
#' getspres_results <- getspres(beta_in = heartgenes3$beta_flipped, 
#'                                se_in = heartgenes3$gcse, 
#'                       study_names_in = heartgenes3$studies, 
#'                     variant_names_in = heartgenes3$variants)
#'
#' # Explore results generated by the getspres function
#' str(getspres_results)
#'
#' # Retrieve number of studies and variants
#' getspres_results$number_variants
#' getspres_results$number_studies
#'
#' # Retrieve SPRE dataset
#' df_spres <- getspres_results$spre_dataset
#' head(df_spres)
#'
#' # Extract SPREs from SPRE dataset
#' head(spres <- df_spres[, "spre"])
#'
#'
#' # Generating forest plots showing SPREs for variants in heartgenes3
#'
#' # Forest plot with default settings
#' # Tip: To store plots set save_plot = TRUE (useful when generating multiple plots)
#' plotspres_res <- plotspres(beta_in = df_spres$beta, 
#'                              se_in = df_spres$se, 
#'                     study_names_in = as.character(df_spres$study_names), 
#'                   variant_names_in = as.character(df_spres$variant_names),
#'                           spres_in = df_spres$spre,
#'                          save_plot = FALSE)
#'
#' # Explore results generated by the plotspres function
#'
#' # Retrieve number of studies and variants
#' plotspres_res$number_variants
#' plotspres_res$number_studies
#'
#' # Retrieve fixed and random-effects meta-analysis results
#' fixed_effect_res <- plotspres_res$fixed_effect_results
#' random_effects_res <- plotspres_res$random_effects_results
#'
#' # Retrieve dataset that was used to generate forest plots
#' df_plotspres <- plotspres_res$spre_forestplot_dataset
#'
#' \donttest{
#'
#' # Retrieve more detailed meta-analysis output
#' str(plotspres_res)
#' 
#'
#'
#' # Explore available options for plotspres forest plots: 
#' #   1. Colorize study-effect estimates according to SPRE statistic values
#' #   2. Label studies by study number instead of study names
#' #   3. Format study labels (useful when using study numbers as study labels)
#' #   4. Change text size
#' #   5. Adjust x and y axes limits
#' #   6. Change method used to estimate amount of heterogeneity from "DL" to "REML"
#' #   7. Run verbosely to show intermediate results
#' #   8. Adjust label (i.e. column header) positions
#' #   9. Save plot as a tiff file (useful when generating multiple plots)
#'
#' # Colorize study-effect estimates according to SPRE statistic values
#'
#' # Use a dual colour palette for observed study effects so that study effect estimates 
#' #   with negative SPRE statistics are coloured differently from those with positive 
#' #   SPRE statistics.
#' plotspres_res <- plotspres(beta_in = df_spres$beta, 
#'                              se_in = df_spres$se, 
#'                     study_names_in = as.character(df_spres$study_names), 
#'                   variant_names_in = as.character(df_spres$variant_names),
#'                           spres_in = df_spres$spre,
#'                spre_colour_palette = c("dual_colour", c("blue","black")),
#'                          save_plot = FALSE)
#'
#'
#' # Use a multi-colour palette for observed study effects so that study effects estimates
#' #   are colored in a gradient according to SPRE statistic values.
#' #   Available multi-colour palettes:
#' #
#' #       gr_devices_palettes: "rainbow", "cm.colors", "topo.colors", "terrain.colors" 
#' #                            and "heat.colors" 
#' #
#' #       colorspace_hcl_hsv_palettes: "rainbow_hcl", "diverge_hcl", "terrain_hcl", 
#' #                                    "sequential_hcl" and "diverge_hsl"
#' #
#' #       color_ramps_palettes: "matlab.like", "matlab.like2", "magenta2green", 
#' #                             "cyan2yellow", "blue2yellow", "green2red", 
#' #                             "blue2green" and "blue2red"
#'
#' plotspres_res <- plotspres(beta_in = df_spres$beta, 
#'                              se_in = df_spres$se, 
#'                     study_names_in = as.character(df_spres$study_names), 
#'                   variant_names_in = as.character(df_spres$variant_names),
#'                           spres_in = df_spres$spre,
#'                spre_colour_palette = c("multi_colour", "rainbow"),
#'                          save_plot = FALSE)
#'
#' # Exploring other options in the plotspres function.
#' #     Label studies by study number instead of study names (option: set_studyNOs_as_studyIDs)
#' #     Format study labels (option: set_study_field_width)
#' #     Adjust text size (option: set_cex)
#' #     Adjust x and y axes limits (options: set_xlim, set_ylim)
#' #     Change method used to estimate heterogeneity from "DL" to "REML" (option: tau2_method)
#' #     Adjust position of x-axis tick marks (option: set_at)
#' #     Run verbosely (option: verbose_output)
#'
#' df_rs10139550 <- subset(df_spres, variant_names == "rs10139550")
#' plotspres_res <- plotspres(beta_in = df_rs10139550$beta, 
#'                              se_in = df_rs10139550$se, 
#'                     study_names_in = as.character(df_rs10139550$study_names), 
#'                   variant_names_in = as.character(df_rs10139550$variant_names),
#'                           spres_in = df_rs10139550$spre,
#'                spre_colour_palette = c("multi_colour", "matlab.like"),
#'           set_studyNOs_as_studyIDs = TRUE,
#'              set_study_field_width = "%03.0f",
#'                            set_cex = 0.75, set_xlim = c(-2,2), set_ylim = c(-1.5,51),
#'                             set_at = c(-0.6, -0.4, -0.2,  0.0,  0.2,  0.4,  0.6),
#'                        tau2_method = "REML", verbose_output = TRUE,
#'                          save_plot = FALSE)
#'
#' # Adjust label (i.e. column header) position, also keep plot in graphics window rather
#' #     than save as tiff file
#' df_rs10139550_3studies <- subset(df_rs10139550, as.numeric(df_rs10139550$study_names) <= 3)
#'
#' # Before adjusting label positions
#' plotspres_res <- plotspres(beta_in = df_rs10139550_3studies$beta, 
#'                              se_in = df_rs10139550_3studies$se, 
#'                     study_names_in = as.character(df_rs10139550_3studies$study_names), 
#'                   variant_names_in = as.character(df_rs10139550_3studies$variant_names),
#'                           spres_in = df_rs10139550_3studies$spre,
#'                spre_colour_palette = c("dual_colour", c("blue","black")),
#'                          save_plot = FALSE)
#'
#' # After adjusting label positions
#' plotspres_res <- plotspres(beta_in = df_rs10139550_3studies$beta, 
#'                              se_in = df_rs10139550_3studies$se, 
#'                     study_names_in = as.character(df_rs10139550_3studies$study_names), 
#'                   variant_names_in = as.character(df_rs10139550_3studies$variant_names),
#'                           spres_in = df_rs10139550_3studies$spre,
#'                spre_colour_palette = c("dual_colour", c("blue","black")),
#'                      adjust_labels = 1.7, save_plot = FALSE)
#' }
#'
#' @export
plotspres <- function(beta_in, se_in, study_names_in, variant_names_in, spres_in, ...) UseMethod("plotspres")

#' @describeIn plotspres Generates forest plots showing \emph{SPRE} statistics
#' @export
plotspres.default <- function(beta_in, se_in, study_names_in, variant_names_in, 
                              spres_in, spre_colour_palette = c("mono_colour", "black"), 
                              set_studyNOs_as_studyIDs = FALSE, set_study_field_width = "%02.0f", 
                              set_cex = 0.66, set_xlim, set_ylim, set_at, tau2_method = "DL", 
                              adjust_labels = 1, save_plot = TRUE, verbose_output = FALSE, ...) {

    # Check whether all required variables are present
    if (missing(beta_in))
        stop("Beta values missing, need to specify a numeric vector of observed study effects.")
 
    if (missing(se_in))
        stop("Standard errors for study effect-size estimates missing, need to specify a numeric vector of standard errors.")

    if (missing(study_names_in))
        stop("Study names missing, need to specify a character vector of study names.")

    if (missing(variant_names_in))
        stop("Variant names missing, need to specify a character vector of variant names.")
        
    if (missing(spres_in))
        stop("SPRE values missing, need to specify a numeric vector of SPRE statistics.")


    
    # Verify datatypes of required variables
    if (!is.numeric(c(beta_in, se_in, spres_in))) {

        stop("beta_in, se_in and spres_in should be of type, numeric.")

    }


    if (!is.character(c(variant_names_in, study_names_in))) {

        stop("variant_names_in and study_names_in should be of type, character.")

    }
    
    plotspres_results <- generate_spre_forestplot(beta_in, se_in, study_names_in, variant_names_in,
                                                  spres_in, spre_colour_palette, set_studyNOs_as_studyIDs, 
                                                  set_study_field_width, set_cex, set_xlim, set_ylim,
                                                  set_at, tau2_method, adjust_labels, save_plot, 
                                                  verbose_output)
    
    plotspres_results$call <- match.call()
    
    class(plotspres_results) <- "plotspres"
    
    plotspres_results
    
}

#' @export
print.plotspres <- function(x, ..., verbose_output = FALSE) {

    cat("Call:\n")
    print(x$call)

    cat("\nnumber_studies:\n")
    print(x$number_studies)

    cat("\nnumber_variants:\n")
    print(x$number_variants)

    cat("\nDataset structure:\n")
    print(str(x$spre_forestplot_dataset))

}
