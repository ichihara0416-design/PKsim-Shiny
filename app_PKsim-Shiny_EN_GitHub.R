# PKsim-Shiny
# Pharmacokinetic simulation application based on a linear
# one-compartment model
#
# Copyright (c) 2026 Yoshinori Ichihara
# Licensed under the MIT License.
# See the LICENSE file for details.
#
# This software may be used, modified, and redistributed for
# educational, research, and other non-clinical purposes.
#
# IMPORTANT:
# This software is not a validated medical device and is not intended
# for clinical decision-making, patient care, diagnosis, treatment,
# or individual dose adjustment.
# Do not use its outputs for clinical purposes.
#


# ==============================================================================
# QUICK START FOR FIRST-TIME USERS
# ==============================================================================
#
# English:
#   In normal use, you only need to do three things:
#   1) Open app.R in RStudio.
#   2) Edit only the editable section below when customization is needed, then save.
#   3) Click "Run App" at the top of RStudio.
#
#   Missing R packages are installed automatically only when needed. An internet
#   connection is required for this first-time installation. The first launch may take
#   about five minutes or longer depending on the internet connection and PC.
#   Messages will appear in the Console during installation. Later launches normally
#   do not reinstall packages. Test the app once on the instructor's PC before class.
# ==============================================================================


################################################################################################
################################################################################################
###                                                                                          ###
###                                  ONLY EDIT THIS AREA                                  ###
###                                                                                          ###
################################################################################################
################################################################################################

# ==============================================================================
# EDITABLE CONTENT
# ==============================================================================
# WHAT CAN BE EDITED HERE
#
#
#   App title                           → APP_TEXT$app_title
#   Tab captions                       → APP_TEXT$tabs
#   Headings and short text            → APP_TEXT$section
#   Input-field labels                 → APP_TEXT$labels
#   Visible option labels              → APP_TEXT$choices
#   Instructions in Tabs 4, 8, and 9  → APP_TEXT$instructions
#   Displayed equations                → APP_TEXT$formulas
#   Plot labels and titles             → APP_TEXT$plot
#   Startup drug-name notes            → APP_DEFAULTS$drug_names
#
# SAFE EDITING RULES
#      Edit only text inside "..." unless the instructions explicitly say otherwise.
#      Do not delete commas at the ends of lines.
#      Do not change parentheses, list(), or key names such as tab1 and dose_iv.
#      In equations, a backslash is written as \\. Keep existing \\ characters.
#      APP_DEFAULTS changes only startup drug-name notes.
#      Changing a drug name does not change any numerical input, PK calculation,
#      AUC, Cmax, Tmax, result, or curve. It is only a note/display name.
#
# CHECK AFTER EDITING
#   A. Save app.R.
#   B. Click "Run App" in RStudio.
#      Confirm that all nine tabs open without a red error message.
#      Confirm that your changes appear in the app.
# ------------------------------------------------------------------------------

APP_TEXT <- list(
  # App title: changes the main title only; calculations are unchanged.
  app_title = "PKsim-Shiny: Pharmacokinetic Simulations Using a One-Compartment Model",

  # Tab captions: tab1–tab9 are the tab names from left to right. Only captions change; calculations do not.
  tabs = list(
    tab1 = "IV Bolus Single Dose",
    tab2 = "Oral Single Dose",
    tab3 = "IV Drip Infusion",
    tab4 = "Oral Single Dose (CLtot=CLh+CLr)",
    tab5 = "IV Bolus Repeated Dose",
    tab6 = "IV Bolus Repeated, Changed Dose",
    tab7 = "Oral Repeated Dose",
    tab8 = "Oral Repeated, 2 Comparison",
    tab9 = "Oral Repeated (CLtot=CLh+CLr)"
  ),

  # Headings and short text: edits the on-screen heading or short text identified by each key. Display only; calculations do not change.
  section = list(
    normal = "Normal Condition",
    disease = "Disease Condition",
    condition1 = "Condition 1",
    condition2 = "Condition 2",
    pk_formula = "Pharmacokinetic equation:",
    pk_formula_oral_repeated = "Pharmacokinetic equation (repeated oral dosing):",
    during_infusion = "During infusion:",
    after_infusion = "After infusion:",
    relation_t_half = "Relationship among t1/2, ke, and CLtot:",
    relation_clearance = "Relationship among CLtot, CLr, and CLh:",
    egfr = "eGFR calculation (using the DuBois formula):",
    ccr = "Ccr calculation (Cockcroft-Gault equation):",
    css_reference = "Reference equation for average steady-state concentration:",
    repeated_explanation = "This equation represents the concentration-time profile as the sum of the contributions from each dose."
  ),

  # Input labels: edits input-field labels. Input IDs, startup values, and calculations remain unchanged.
  labels = list(
    drug_name = "Drug Name",
    drug_name1 = "Drug Name 1",
    drug_name2 = "Drug Name 2",
    dose_iv = "Dose: Div (mg)",
    dose_oral = "Dose: Dpo (mg)",
    dose_initial = "Initial Dose (mg)",
    initial_dose_iv = "Initial Dose: Div (mg)",
    changed_dose_iv = "Changed Dose: Div (mg)",
    dose_normal = "Dose, Normal Condition (mg)",
    dose_changed_disease = "Changed Dose, Disease Condition (mg)",
    dose1 = "Dose 1 (mg)",
    dose2 = "Dose 2 (mg)",
    vd_per_kg = "Volume of Distribution per Body Weight (Vd/kg) (L/kg)",
    vd_per_kg1 = "Volume of Distribution per Body Weight 1 (Vd/kg) (L/kg)",
    vd_per_kg2 = "Volume of Distribution per Body Weight 2 (Vd/kg) (L/kg)",
    body_weight = "Body Weight (kg)",
    body_weight1 = "Body Weight 1 (kg)",
    body_weight2 = "Body Weight 2 (kg)",
    height = "Height (cm)",
    sex = "Sex",
    age = "Age (years)",
    scr = "Serum Creatinine (Scr) (mg/dL)",
    ka = "Absorption Rate Constant (ka) (1/hr)",
    ka1 = "Absorption Rate Constant 1 (ka) (1/hr)",
    ka2 = "Absorption Rate Constant 2 (ka) (1/hr)",
    bioavailability = "Bioavailability (F)",
    bioavailability1 = "Bioavailability 1 (F)",
    bioavailability2 = "Bioavailability 2 (F)",
    infusion_rate = "Infusion Rate: R (mg/hr)",
    infusion_time = "Infusion Time (hr)",
    calculation_method = "Choose Calculation Method",
    calculation_method1 = "Calculation Method 1",
    calculation_method2 = "Calculation Method 2",
    clearance = "Total Clearance (CLtot) (L/hr)",
    clearance1 = "Total Clearance 1 (CLtot) (L/hr)",
    clearance2 = "Total Clearance 2 (CLtot) (L/hr)",
    clearance_normal = "Total Clearance, Normal Condition (CLtot) (L/hr)",
    ke = "Elimination Rate Constant (ke) (1/hr)",
    ke1 = "Elimination Rate Constant 1 (ke) (1/hr)",
    ke2 = "Elimination Rate Constant 2 (ke) (1/hr)",
    half_life = "Half-Life (t1/2) (hr)",
    half_life1 = "Half-Life 1 (t1/2) (hr)",
    half_life2 = "Half-Life 2 (t1/2) (hr)",
    ae = "Fraction Excreted Unchanged in Urine (Ae)",
    clr_disease = "Renal Clearance, Disease Condition (CLr) (L/hr)",
    clh_disease = "Hepatic Clearance, Disease Condition (CLh) (L/hr)",
    tau = "Dosing Interval (τ) (hr)",
    tau1 = "Dosing Interval 1 (τ) (hr)",
    tau2 = "Dosing Interval 2 (τ) (hr)",
    tau_normal = "Dosing Interval, Normal Condition (τ) (hr)",
    tau_changed = "Changed Dosing Interval, Disease Condition (τ) (hr)",
    number_doses = "Number of Doses",
    number_doses1 = "Number of Doses 1",
    number_doses2 = "Number of Doses 2",
    total_number_doses = "Total Number of Doses",
    initial_number_doses = "Number of Initial Doses",
    changed_number_doses = "Number of Doses After Change",
    simulation_time = "Simulation Time (hr)",
    lower_bound = "Lower Bound of Effective Concentration Range (mg/L)",
    upper_bound = "Upper Bound of Effective Concentration Range (mg/L)"
  ),

  # Option labels: edits visible option labels. Internal values and calculation logic remain unchanged.
  choices = list(
    cltot = "Total Clearance: CLtot",
    ke = "Elimination Rate Constant: ke",
    half_life = "Half-Life: t1/2",
    male = "Male",
    female = "Female"
  ),

  # Instructions: edits guidance shown in Tabs 4, 8, and 9. Inputs, graphs, and calculations remain unchanged.
  instructions = list(
    tab4_curve = "Three plasma concentration curves are shown: blue, normal condition; red, disease condition; green, disease condition after changing the dose.",
    tab4_step1 = "First enter the normal-condition parameters and examine the plasma concentration-time curve, CLr, CLh, and AUC (blue curve).",
    tab4_step2 = "Then, following the disease-condition instructions, calculate how CLr and CLh change and enter the disease-condition CLr and CLh values (red curve).",
    tab4_step3 = "Compare the pharmacokinetic parameters between the normal and disease conditions. Then consider how the dose should be changed to achieve the same AUC as in the normal condition (green curve).",
    tab8_color = "Red: Condition 1; Blue: Condition 2",
    tab9_curve = "Three plasma concentration curves are shown: blue, normal condition; red, disease condition; green, disease condition after changing the dose and dosing interval.",
    tab9_step1 = "First enter the normal-condition parameters and examine the plasma concentration-time curve, CLr, CLh, and AUC (blue curve).",
    tab9_step2 = "Then enter the disease-condition CLr and CLh values and, if needed, change the dosing interval for the disease condition (red curve).",
    tab9_step3 = "Finally, examine the concentration-time profile after changing the dose and dosing interval (green curve)."
  ),

  # Displayed equations: MathJax equations shown on screen. Editing them does not alter calculations. Keep all "\\" characters.
  formulas = list(
    iv_bolus_single = "$$Cp = \\frac{Dose}{Vd} \\times e^{-ke \\times Time}$$",
    oral_single = "$$Cp = F \\times \\frac{Dose}{Vd} \\times \\frac{ka}{ka - ke} \\times (e^{-ke \\times Time} - e^{-ka \\times Time})$$",
    infusion_during = "$$Cp = \\frac{Rate}{ke \\times Vd} \\times (1 - e^{-ke \\times Time})$$",
    infusion_after = "$$Cp = \\frac{Rate}{ke \\times Vd} \\times (1 - e^{-ke \\times Infusion\\ Time}) \\times e^{-ke \\times (Time - Infusion\\ Time)}$$",
    iv_repeated = "$$Cp = \\sum_{i=0}^{n-1} \\left( \\frac{Dose}{Vd} \\times e^{-ke \\times (Time - i \\times \\tau)} \\times (Time \\geq i \\times \\tau) \\right)$$",
    iv_repeated_changed = "$$Cp = \\sum_{i=0}^{n-1} \\left( \\frac{Dose_i}{Vd} \\times e^{-ke \\times (Time - i \\times \\tau)} \\times (Time \\geq i \\times \\tau) \\right)$$",
    oral_repeated = "\n$$Cp = \\sum_{i=0}^{n-1} \\left(\nF \\times \\frac{Dose}{Vd} \\times \\frac{ka}{ka - ke}\n\\times \\left(e^{-ke \\times (Time - i \\times \\tau)} - e^{-ka \\times (Time - i \\times \\tau)}\\right)\n\\times (Time \\geq i \\times \\tau)\n\\right)$$\n",
    half_life_from_ke = "$$t_{1/2} = \\frac{\\ln(2)}{ke}$$",
    ke_from_half_life = "$$ke = \\frac{\\ln(2)}{t_{1/2}}$$",
    clearance_from_ke = "$$CLtot = ke \\times Vd$$",
    bsa = "$$BSA = 0.007184 \\times (Weight^{0.425}) \\times (Height^{0.725})$$",
    egfr_male = "Male: $$eGFR = 175 \\times (Scr^{-1.154}) \\times (Age^{-0.203}) \\times \\frac{BSA}{1.73}$$",
    egfr_female = "Female: $$eGFR = 175 \\times (Scr^{-1.154}) \\times (Age^{-0.203}) \\times 0.742 \\times \\frac{BSA}{1.73}$$",
    ccr_male = "Male: $$Ccr = \\frac{(140 - Age) \\times Weight}{72 \\times Scr}$$",
    ccr_female = "Female: $$Ccr = \\frac{(140 - Age) \\times Weight}{72 \\times Scr} \\times 0.85$$",
    clearance_auc = "$$CLtot = ke \\times Vd = \\frac{F \\times Dpo}{AUC}$$",
    clr = "$$CLr = CLtot \\times Ae$$",
    clh = "$$CLh = CLtot - CLr$$",
    ke_clearance = "$$ke = \\frac{CLtot}{Vd}$$",
    css_iv = "$$Css,ave = \\frac{Dose}{CLtot \\times \\tau}$$",
    css_oral = "$$Css,ave = \\frac{F \\times Dose}{CLtot \\times \\tau}$$"
  ),

  # Plot text: x_axis and y_axis are axis labels; tab1_title–tab9_title are plot titles. Data and curves do not change. Keep the final "(" in Tabs 1–7 and 9 because the drug name is appended after it.
  plot = list(
    x_axis = "Time (hours)",
    y_axis = "Concentration (mg/L)",
    tab1_title = "IV Bolus Single Dose (",
    tab2_title = "Oral Single Dose (",
    tab3_title = "IV Drip Infusion (",
    tab4_title = "Oral Single Dose (CLtot = CLh + CLr) (",
    tab5_title = "IV Bolus Repeated Dose (",
    tab6_title = "IV Bolus Repeated, Changed Dose (",
    tab7_title = "Oral Repeated Dose (",
    tab8_title = "Oral Repeated Dose Comparison",
    tab9_title = "Oral Repeated (CLtot=CLh+CLr) ("
  )
)
# Default drug-name notes
# English:
#   This section changes only the text initially shown in each drug-name field.
#   Drug names are notes used to identify simulation conditions.
#   Changing a name does not change numeric inputs, PK calculations, AUC, Cmax,
#   Tmax, or plotted curves. The order is Tabs 1–7, Tab 8 Conditions 1–2, and Tab 9.
APP_DEFAULTS <- list(
  drug_names = c("Drug A", "Drug B", "Drug C", "Drug D", "Drug E", "Drug F", "Drug G", "Drug H-1", "Drug H-2", "Drug I")
)

# ------------------------------------------------------------------------------
# HOW TO CHANGE NUMERIC STARTUP VALUES: TAB 1 EXAMPLE
# ------------------------------------------------------------------------------
#
# Numeric defaults are defined by `value = number` inside numericInput() in the UI
# section below. Because line numbers change whenever comments or functions are added,
# use RStudio's search function rather than relying on fixed line numbers.
#
# HOW TO SEARCH
#
#   Press Ctrl+F (Command+F on Mac), enter the search term below, and change only
#   the number after `value =`. Do not change the input ID, LBL$..., parentheses,
#   quotes, or final comma.
#
# TO LOCATE THE WHOLE TAB 1 UI BLOCK
#   Search for: # Tab 1
#   The Tab 1 UI block continues until immediately before the next "# Tab 2" heading.
#
# TAB 1 NUMERIC DEFAULTS
#
#   Dose
#     Search term: numericInput("dose1"
#     Current: numericInput("dose1", LBL$dose_iv, value = 500),
#     Example: to use 250 mg, change only `value = 500` to `value = 250`.
#
#   Vd per kg
#     Search term: numericInput("V1"
#     Current: numericInput("V1", LBL$vd_per_kg, value = 0.6),
#     Example: to use 0.7 L/kg, change only `value = 0.6` to `value = 0.7`.
#
#   Body weight
#     Search term: numericInput("weight1"
#     Current: numericInput("weight1", LBL$body_weight, value = 70),
#     Example: to use 60 kg, change only `value = 70` to `value = 60`.
#
#   CLtot
#     Search term: numericInput("CLtot1"
#     Current: numericInput("CLtot1", LBL$clearance, value = 6)
#     Example: to use 5 L/hr, change only `value = 6` to `value = 5`.
#
#   Elimination rate constant (ke)
#     Search term: numericInput("ke1"
#     Current: numericInput("ke1", LBL$ke, value = 0.1)
#     Example: to use 0.08 /hr, change only `value = 0.1` to `value = 0.08`.
#
#   Half-life
#     Search term: numericInput("t_half1"
#     Current: numericInput("t_half1", LBL$half_life, value = 6)
#     Example: to use 8 hr, change only `value = 6` to `value = 8`.
#
#   Simulation time
#     Search term: numericInput("time1"
#     Current: numericInput("time1", LBL$simulation_time, value = 24),
#     Example: to use 48 hr, change only `value = 24` to `value = 48`.
#
#   Lower bound of effective concentration range
#     Search term: numericInput("effective_range_lower1"
#     Current: value = 5
#
#   Upper bound of effective concentration range
#     Search term: numericInput("effective_range_upper1"
#     Current: value = 15
#
# NOTE ABOUT CLtot, ke, AND t1/2
#
#   Only the value corresponding to the selected calculation method is used.
#   CLtot is normally selected at startup. Changing the default selected method requires
#   editing radioButtons(), so assistance from someone familiar with R is recommended.
#
# ------------------------------------------------------------------------------
# CUSTOMIZATION CHECKLIST
# ------------------------------------------------------------------------------
#   To change the app title:
#       Search for `app_title =` with Ctrl+F.
#   To change tab captions:
#       Search for `tabs = list(` with Ctrl+F.
#   To change input-field labels:
#       Search for `labels = list(` with Ctrl+F.
#   To change on-screen instructions:
#       Search for `instructions = list(` with Ctrl+F.
#   To change displayed equations:
#       Search for `formulas = list(` with Ctrl+F.
#   To change plot titles or axis labels:
#       Search for `plot = list(` with Ctrl+F.
#   To change startup drug-name notes:
#       Search for `drug_names = c(` with Ctrl+F.
#   To change startup numeric values:
#       Search for the input-field ID and change only `value =` in numericInput().
#
# ------------------------------------------------------------------------------
# IF AN ERROR OCCURS
# ------------------------------------------------------------------------------
#
#   Common causes are a deleted comma, quote, or parenthesis, or entering a unit
#   together with a number. Write `value = 250`, not `value = 250 mg`.
#
# ==============================================================================
# END OF EDITABLE CONTENT
# ==============================================================================

################################################################################################
###                                                                                            ###
###                              DO NOT EDIT BELOW THIS LINE                              ###
###                                                                                            ###
################################################################################################
################################################################################################

# Internal implementation values and aliases
# These lines are intentionally outside the editable section.
APP_INTERNAL_VALUES <- list(CLtot = "CLtot", ke = "ke", half_life = "t1/2")
TXT <- APP_TEXT
LBL <- APP_TEXT$labels
SEC <- APP_TEXT$section
FML <- APP_TEXT$formulas
PLT <- APP_TEXT$plot

# ==============================================================================

# Check required packages and install only those that are missing.
# An internet connection is required when missing packages are installed.
required_packages <- c("shiny", "ggplot2", "markdown", "showtext", "sysfonts", "curl")
new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]

if (length(new_packages)) {
  install.packages(new_packages)
}

library(shiny)
library(ggplot2)
library(markdown)
library(showtext)
library(sysfonts)
library(curl)

# If Google Fonts cannot be downloaded, continue with the system default font.
tryCatch(
  {
    font_add_google("Noto Sans JP", "jp")
    showtext_auto()
  },
  error = function(e) {
    message("Google Fonts could not be retrieved. The app will use a system font.")
  }
)

# ----------------------------
# Functions
# ----------------------------

# eGFR and Ccr calculation functions
calculate_eGFR <- function(scr, age, weight, height, sex) {
  bsa <- 0.007184 * (weight^0.425) * (height^0.725)
  if (sex == "Male") {
    return(175 * (scr ^ -1.154) * (age ^ -0.203) * (bsa / 1.73))
  } else {
    return(175 * (scr ^ -1.154) * (age ^ -0.203) * 0.742 * (bsa / 1.73))
  }
}

calculate_Ccr <- function(scr, age, weight, sex) {
  if (sex == "Male") {
    return(((140 - age) * weight) / (72 * scr))
  } else {
    return((((140 - age) * weight) / (72 * scr)) * 0.85)
  }
}

# Convert half-life to ke
t_half_to_ke <- function(t_half) {
  log(2) / t_half
}

# AUC for each 24-hour interval
calc_auc24 <- function(Time, Cp) {
  dt <- diff(Time)[1]
  points_per_24h <- round(24 / dt)
  n_block <- floor(length(Time) / points_per_24h)
  
  if (n_block < 1) return(numeric(0))
  
  auc24 <- numeric(n_block)
  for (i in seq_len(n_block)) {
    start_idx <- (i - 1) * points_per_24h + 1
    end_idx <- i * points_per_24h
    auc24[i] <- sum(Cp[start_idx:end_idx]) * dt
  }
  auc24
}

# lower bound crossing time
calc_crossing_times <- function(Time, Cp, lower) {
  idx <- which(diff(sign(Cp - lower)) != 0)
  if (length(idx) == 0) return(numeric(0))
  sort(Time[idx])
}

# Single IV bolus dose
simulate_iv_bolus_single <- function(dose, Vd, ke, Time) {
  Cp <- dose / Vd * exp(-ke * Time)
  AUC <- dose / (ke * Vd)
  list(Cp = Cp, AUC = AUC)
}

# Single oral dose
simulate_oral_single <- function(dose, Vd, ke, ka, F, Time) {
  Cp <- F * dose / Vd * (ka / (ka - ke)) * (exp(-ke * Time) - exp(-ka * Time))
  AUC <- F * dose / (ke * Vd)
  list(Cp = Cp, AUC = AUC)
}

# IV infusion
simulate_iv_infusion <- function(rate, Vd, ke, infusion_time, Time) {
  Cp <- ifelse(
    Time <= infusion_time,
    rate / (ke * Vd) * (1 - exp(-ke * Time)),
    rate / (ke * Vd) * (1 - exp(-ke * infusion_time)) * exp(-ke * (Time - infusion_time))
  )
  AUC <- sum(Cp) * diff(Time)[1]
  list(Cp = Cp, AUC = AUC)
}

# Repeated IV bolus doses
simulate_iv_bolus_repeated <- function(dose, Vd, ke, tau, n, Time) {
  Cp <- rep(0, length(Time))
  AUC_list <- numeric(n)
  
  for (i in seq_len(n)) {
    start_time <- (i - 1) * tau
    Cp_dose <- dose / Vd * exp(-ke * (Time - start_time)) * (Time >= start_time)
    Cp <- Cp + Cp_dose
    AUC_list[i] <- dose / (ke * Vd)
  }
  
  list(
    Cp = Cp,
    AUC_list = AUC_list,
    totalAUC = sum(AUC_list)
  )
}

# Repeated IV bolus doses with a dose change
simulate_iv_bolus_repeated_changed <- function(initial_dose, changed_dose, initial_dose_num, Vd, ke, tau, n, Time) {
  Cp <- rep(0, length(Time))
  AUC_list <- numeric(n)
  
  for (i in seq_len(n)) {
    this_dose <- ifelse(i <= initial_dose_num, initial_dose, changed_dose)
    start_time <- (i - 1) * tau
    Cp_dose <- this_dose / Vd * exp(-ke * (Time - start_time)) * (Time >= start_time)
    Cp <- Cp + Cp_dose
    AUC_list[i] <- this_dose / (ke * Vd)
  }
  
  list(
    Cp = Cp,
    AUC_list = AUC_list,
    totalAUC = sum(AUC_list)
  )
}

# Repeated oral doses
simulate_oral_repeated <- function(dose, Vd, ke, ka, F, tau, n, Time) {
  Cp <- rep(0, length(Time))
  AUC_list <- numeric(n)
  
  for (i in seq_len(n)) {
    start_time <- (i - 1) * tau
    Cp_dose <- F * dose / Vd * (ka / (ka - ke)) *
      (exp(-ke * (Time - start_time)) - exp(-ka * (Time - start_time))) *
      (Time >= start_time)
    Cp <- Cp + Cp_dose
    AUC_list[i] <- F * dose / (ke * Vd)
  }
  
  list(
    Cp = Cp,
    AUC_list = AUC_list,
    totalAUC = sum(AUC_list)
  )
}

# ----------------------------
# UI
# ----------------------------
ui <- fluidPage(
  titlePanel(TXT$app_title),
  
  tabsetPanel(
    type = "tabs",
    
    # --------------------------------------------------
    # Tab 1
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab1,
      sidebarLayout(
        sidebarPanel(
          textInput("drug_name1", LBL$drug_name, value = APP_DEFAULTS$drug_names[1]),
          numericInput("dose1", LBL$dose_iv, value = 500),
          numericInput("V1", LBL$vd_per_kg, value = 0.6),
          numericInput("weight1", LBL$body_weight, value = 70),
          
          radioButtons(
            "cl_or_ke1", LBL$calculation_method,
            choices = stats::setNames(
              c("CLtot", "ke", "t1/2"),
              c(TXT$choices$cltot, TXT$choices$ke, TXT$choices$half_life)
            )
          ),
          conditionalPanel(
            condition = "input.cl_or_ke1 == 'CLtot'",
            numericInput("CLtot1", LBL$clearance, value = 6)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke1 == 'ke'",
            numericInput("ke1", LBL$ke, value = 0.1)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke1 == 't1/2'",
            numericInput("t_half1", LBL$half_life, value = 6)
          ),
          
          numericInput("time1", LBL$simulation_time, value = 24),
          numericInput("effective_range_lower1", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper1", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot1"),
          textOutput("AUC1"),
          textOutput("results1"),
          textOutput("crossingTimes1"),
          tags$h4(SEC$pk_formula),
          withMathJax(FML$iv_bolus_single),
          tags$h4(SEC$relation_t_half),
          withMathJax(FML$half_life_from_ke),
          withMathJax(FML$ke_from_half_life),
          withMathJax(FML$clearance_from_ke)
        )
      )
    ),
    
    # --------------------------------------------------
    # Tab 2
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab2,
      sidebarLayout(
        sidebarPanel(
          textInput("drug_name2", LBL$drug_name, value = APP_DEFAULTS$drug_names[2]),
          numericInput("dose2", LBL$dose_oral, value = 500),
          numericInput("V2", LBL$vd_per_kg, value = 0.6),
          numericInput("weight2", LBL$body_weight, value = 70),
          numericInput("ka2", LBL$ka, value = 1.0),
          numericInput("F2", LBL$bioavailability, value = 0.8),
          
          radioButtons(
            "cl_or_ke2", LBL$calculation_method,
            choices = stats::setNames(
              c("CLtot", "ke", "t1/2"),
              c(TXT$choices$cltot, TXT$choices$ke, TXT$choices$half_life)
            )
          ),
          conditionalPanel(
            condition = "input.cl_or_ke2 == 'CLtot'",
            numericInput("CLtot2", LBL$clearance, value = 6)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke2 == 'ke'",
            numericInput("ke2", LBL$ke, value = 0.1)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke2 == 't1/2'",
            numericInput("t_half2", LBL$half_life, value = 6)
          ),
          
          numericInput("time2", LBL$simulation_time, value = 24),
          numericInput("effective_range_lower2", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper2", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot2"),
          textOutput("AUC2"),
          textOutput("results2"),
          textOutput("crossingTimes2"),
          textOutput("CmaxTmax2"),
          tags$h4(SEC$pk_formula),
          withMathJax(FML$oral_single),
          tags$h4(SEC$relation_t_half),
          withMathJax(FML$half_life_from_ke),
          withMathJax(FML$ke_from_half_life),
          withMathJax(FML$clearance_from_ke)
        )
      )
    ),
    
    # --------------------------------------------------
    # Tab 3
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab3,
      sidebarLayout(
        sidebarPanel(
          textInput("drug_name3", LBL$drug_name, value = APP_DEFAULTS$drug_names[3]),
          numericInput("rate3", LBL$infusion_rate, value = 50),
          numericInput("V3", LBL$vd_per_kg, value = 0.6),
          numericInput("weight3", LBL$body_weight, value = 70),
          numericInput("infusion_time3", LBL$infusion_time, value = 2),
          
          radioButtons(
            "cl_or_ke3", LBL$calculation_method,
            choices = stats::setNames(
              c("CLtot", "ke", "t1/2"),
              c(TXT$choices$cltot, TXT$choices$ke, TXT$choices$half_life)
            )
          ),
          conditionalPanel(
            condition = "input.cl_or_ke3 == 'CLtot'",
            numericInput("CLtot3", LBL$clearance, value = 6)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke3 == 'ke'",
            numericInput("ke3", LBL$ke, value = 0.1)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke3 == 't1/2'",
            numericInput("t_half3", LBL$half_life, value = 6)
          ),
          
          numericInput("time3", LBL$simulation_time, value = 24),
          numericInput("effective_range_lower3", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper3", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot3"),
          textOutput("AUC3"),
          textOutput("results3"),
          textOutput("crossingTimes3"),
          tags$h4(SEC$pk_formula),
          tags$h5(SEC$during_infusion),
          withMathJax(FML$infusion_during),
          tags$h5(SEC$after_infusion),
          withMathJax(FML$infusion_after),
          tags$h4(SEC$relation_t_half),
          withMathJax(FML$half_life_from_ke),
          withMathJax(FML$ke_from_half_life),
          withMathJax(FML$clearance_from_ke)
        )
      )
    ),
    
    # --------------------------------------------------
    # Tab 4
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab4,
      sidebarLayout(
        sidebarPanel(
          tags$h4(SEC$normal),
          textInput("drug_name4", LBL$drug_name, value = APP_DEFAULTS$drug_names[4]),
          numericInput("dose4", LBL$dose_initial, value = 500),
          numericInput("V4", LBL$vd_per_kg, value = 0.6),
          numericInput("height4", LBL$height, value = 170),
          numericInput("weight4", LBL$body_weight, value = 70),
          selectInput("sex4", LBL$sex, choices = c(TXT$choices$male, TXT$choices$female)),
          numericInput("age4", LBL$age, value = 40),
          numericInput("scr4", LBL$scr, value = 1),
          numericInput("ka4", LBL$ka, value = 1.0),
          numericInput("F4", LBL$bioavailability, value = 0.8),
          numericInput("CLtot4", LBL$clearance_normal, value = 6),
          numericInput("Ae4", LBL$ae, value = 0.3),
          
          tags$hr(),
          tags$h4(SEC$disease),
          numericInput("CLr_disease4", LBL$clr_disease, value = 2),
          numericInput("CLh_disease4", LBL$clh_disease, value = 2),
          numericInput("dose_disease4", LBL$dose_changed_disease, value = 250),
          
          tags$hr(),
          numericInput("time4", LBL$simulation_time, value = 24),
          numericInput("effective_range_lower4", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper4", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot4"),
          textOutput("BSA4"),
          textOutput("eGFR4"),
          textOutput("Ccr4"),
          textOutput("AUC4"),
          textOutput("results4"),
          textOutput("crossingTimes4"),
          tags$h4(TXT$instructions$tab4_curve),
          tags$h4(TXT$instructions$tab4_step1),
          tags$h4(TXT$instructions$tab4_step2),
          tags$h4(TXT$instructions$tab4_step3),
          tags$h4(SEC$egfr),
          withMathJax(FML$bsa),
          withMathJax(FML$egfr_male),
          withMathJax(FML$egfr_female),
          tags$h4(SEC$ccr),
          withMathJax(FML$ccr_male),
          withMathJax(FML$ccr_female),
          tags$h4(SEC$pk_formula),
          withMathJax(FML$clearance_auc),
          withMathJax(FML$clr),
          withMathJax(FML$clh),
          withMathJax(FML$oral_single)
        )
      )
    ),
    
    # --------------------------------------------------
    # Tab 5
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab5,
      sidebarLayout(
        sidebarPanel(
          textInput("drug_name5", LBL$drug_name, value = APP_DEFAULTS$drug_names[5]),
          numericInput("dose5", LBL$dose_iv, value = 500),
          numericInput("V5", LBL$vd_per_kg, value = 0.6),
          numericInput("weight5", LBL$body_weight, value = 70),
          
          radioButtons(
            "cl_or_ke5", LBL$calculation_method,
            choices = stats::setNames(
              c("CLtot", "ke", "t1/2"),
              c(TXT$choices$cltot, TXT$choices$ke, TXT$choices$half_life)
            )
          ),
          conditionalPanel(
            condition = "input.cl_or_ke5 == 'CLtot'",
            numericInput("CLtot5", LBL$clearance, value = 6)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke5 == 'ke'",
            numericInput("ke5", LBL$ke, value = 0.1)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke5 == 't1/2'",
            numericInput("t_half5", LBL$half_life, value = 6)
          ),
          
          numericInput("tau5", LBL$tau, value = 12),
          numericInput("n5", LBL$number_doses, value = 5),
          numericInput("time5", LBL$simulation_time, value = 100),
          numericInput("effective_range_lower5", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper5", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot5"),
          textOutput("AUC5"),
          textOutput("totalAUC5"),
          textOutput("AUC24h5"),
          textOutput("results5"),
          textOutput("crossingTimes5"),
          textOutput("CssAve5"),
          tags$h4(SEC$pk_formula),
          withMathJax(FML$iv_repeated),
          tags$h4(SEC$repeated_explanation),
          tags$h4(SEC$relation_t_half),
          withMathJax(FML$half_life_from_ke),
          withMathJax(FML$ke_from_half_life),
          withMathJax(FML$clearance_from_ke),
          tags$h4(SEC$css_reference),
          withMathJax(FML$css_iv)
        )
      )
    ),
    
    # --------------------------------------------------
    # Tab 6
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab6,
      sidebarLayout(
        sidebarPanel(
          textInput("drug_name6", LBL$drug_name, value = APP_DEFAULTS$drug_names[6]),
          numericInput("dose6_1", LBL$initial_dose_iv, value = 500),
          numericInput("dose6_2", LBL$changed_dose_iv, value = 250),
          numericInput("V6", LBL$vd_per_kg, value = 0.6),
          numericInput("weight6", LBL$body_weight, value = 70),
          
          radioButtons(
            "cl_or_ke6", LBL$calculation_method,
            choices = stats::setNames(
              c("CLtot", "ke", "t1/2"),
              c(TXT$choices$cltot, TXT$choices$ke, TXT$choices$half_life)
            )
          ),
          conditionalPanel(
            condition = "input.cl_or_ke6 == 'CLtot'",
            numericInput("CLtot6", LBL$clearance, value = 6)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke6 == 'ke'",
            numericInput("ke6", LBL$ke, value = 0.1)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke6 == 't1/2'",
            numericInput("t_half6", LBL$half_life, value = 6)
          ),
          
          numericInput("tau6", LBL$tau, value = 12),
          numericInput("n6", LBL$total_number_doses, value = 5),
          numericInput("initial_dose_num6", LBL$initial_number_doses, value = 3),
          
          numericInput("time6", LBL$simulation_time, value = 100),
          numericInput("effective_range_lower6", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper6", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot6"),
          textOutput("AUC6"),
          textOutput("totalAUC6"),
          textOutput("AUC24h6"),
          textOutput("results6"),
          textOutput("crossingTimes6"),
          textOutput("CssAve6"),
          tags$h4(SEC$pk_formula),
          withMathJax(FML$iv_repeated_changed),
          tags$h4(SEC$repeated_explanation),
          tags$h4(SEC$relation_t_half),
          withMathJax(FML$half_life_from_ke),
          withMathJax(FML$ke_from_half_life),
          withMathJax(FML$clearance_from_ke),
          tags$h4(SEC$css_reference),
          withMathJax(FML$css_iv)
        )
      )
    ),
    
    # --------------------------------------------------
    # Tab 7
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab7,
      sidebarLayout(
        sidebarPanel(
          textInput("drug_name7", LBL$drug_name, value = APP_DEFAULTS$drug_names[7]),
          numericInput("dose7", LBL$dose_oral, value = 500),
          numericInput("V7", LBL$vd_per_kg, value = 0.6),
          numericInput("weight7", LBL$body_weight, value = 70),
          numericInput("ka7", LBL$ka, value = 1),
          numericInput("F7", LBL$bioavailability, value = 0.8),
          
          radioButtons(
            "cl_or_ke7", LBL$calculation_method,
            choices = stats::setNames(
              c("CLtot", "ke", "t1/2"),
              c(TXT$choices$cltot, TXT$choices$ke, TXT$choices$half_life)
            )
          ),
          conditionalPanel(
            condition = "input.cl_or_ke7 == 'CLtot'",
            numericInput("CLtot7", LBL$clearance, value = 6)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke7 == 'ke'",
            numericInput("ke7", LBL$ke, value = 0.1)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke7 == 't1/2'",
            numericInput("t_half7", LBL$half_life, value = 6)
          ),
          
          numericInput("tau7", LBL$tau, value = 12),
          numericInput("n7", LBL$number_doses, value = 5),
          numericInput("time7", LBL$simulation_time, value = 100),
          numericInput("effective_range_lower7", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper7", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot7"),
          textOutput("AUC7"),
          textOutput("totalAUC7"),
          textOutput("AUC24h7"),
          textOutput("results7"),
          textOutput("crossingTimes7"),
          textOutput("CssAve7"),
          tags$h4(SEC$pk_formula_oral_repeated),
          withMathJax(FML$oral_repeated),
          tags$h4(SEC$relation_t_half),
          withMathJax(FML$half_life_from_ke),
          withMathJax(FML$ke_from_half_life),
          withMathJax(FML$clearance_from_ke),
          tags$h4(SEC$css_reference),
          withMathJax(FML$css_oral)
        )
      )
    ),
    
    # --------------------------------------------------
    # Tab 8
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab8,
      sidebarLayout(
        sidebarPanel(
          tags$h4(SEC$condition1),
          textInput("drug_name8_1", LBL$drug_name1, value = APP_DEFAULTS$drug_names[8]),
          numericInput("dose8_1", LBL$dose1, value = 500),
          numericInput("V8_1", LBL$vd_per_kg1, value = 0.6),
          numericInput("weight8_1", LBL$body_weight1, value = 70),
          numericInput("ka8_1", LBL$ka1, value = 1),
          numericInput("F8_1", LBL$bioavailability1, value = 0.8),
          
          radioButtons(
            "cl_or_ke8_1", LBL$calculation_method1,
            choices = stats::setNames(
              c("CLtot", "ke", "t1/2"),
              c(TXT$choices$cltot, TXT$choices$ke, TXT$choices$half_life)
            )
          ),
          conditionalPanel(
            condition = "input.cl_or_ke8_1 == 'CLtot'",
            numericInput("CLtot8_1", LBL$clearance1, value = 6)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke8_1 == 'ke'",
            numericInput("ke8_1", LBL$ke1, value = 0.1)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke8_1 == 't1/2'",
            numericInput("t_half8_1", LBL$half_life1, value = 6)
          ),
          
          numericInput("tau8_1", LBL$tau1, value = 12),
          numericInput("n8_1", LBL$number_doses1, value = 10),
          
          tags$hr(),
          
          tags$h4(SEC$condition2),
          textInput("drug_name8_2", LBL$drug_name2, value = APP_DEFAULTS$drug_names[9]),
          numericInput("dose8_2", LBL$dose2, value = 250),
          numericInput("V8_2", LBL$vd_per_kg2, value = 0.6),
          numericInput("weight8_2", LBL$body_weight2, value = 70),
          numericInput("ka8_2", LBL$ka2, value = 1),
          numericInput("F8_2", LBL$bioavailability2, value = 0.8),
          
          radioButtons(
            "cl_or_ke8_2", LBL$calculation_method2,
            choices = stats::setNames(
              c("CLtot", "ke", "t1/2"),
              c(TXT$choices$cltot, TXT$choices$ke, TXT$choices$half_life)
            )
          ),
          conditionalPanel(
            condition = "input.cl_or_ke8_2 == 'CLtot'",
            numericInput("CLtot8_2", LBL$clearance2, value = 6)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke8_2 == 'ke'",
            numericInput("ke8_2", LBL$ke2, value = 0.1)
          ),
          conditionalPanel(
            condition = "input.cl_or_ke8_2 == 't1/2'",
            numericInput("t_half8_2", LBL$half_life2, value = 6)
          ),
          
          numericInput("tau8_2", LBL$tau2, value = 24),
          numericInput("n8_2", LBL$number_doses2, value = 5),
          
          tags$hr(),
          numericInput("time8", LBL$simulation_time, value = 150),
          numericInput("effective_range_lower8", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper8", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot8"),
          textOutput("AUC8_1"),
          textOutput("totalAUC8_1"),
          textOutput("AUC24h8_1"),
          textOutput("CssAve8_1"),
          textOutput("results8_1"),
          tags$hr(),
          textOutput("AUC8_2"),
          textOutput("totalAUC8_2"),
          textOutput("AUC24h8_2"),
          textOutput("CssAve8_2"),
          textOutput("results8_2"),
          tags$hr(),
          textOutput("crossingTimes8"),
          tags$h4(SEC$pk_formula_oral_repeated),
          withMathJax(FML$oral_repeated),
          tags$h4(TXT$instructions$tab8_color)
        )
      )
    ),
    
    # --------------------------------------------------
    # Tab 9
    # --------------------------------------------------
    tabPanel(
      TXT$tabs$tab9,
      sidebarLayout(
        sidebarPanel(
          tags$h4(SEC$normal),
          textInput("drug_name9", LBL$drug_name, value = APP_DEFAULTS$drug_names[10]),
          numericInput("dose9", LBL$dose_normal, value = 500),
          numericInput("V9", LBL$vd_per_kg, value = 0.6),
          numericInput("height9", LBL$height, value = 170),
          numericInput("weight9", LBL$body_weight, value = 70),
          selectInput("sex9", LBL$sex, choices = c(TXT$choices$male, TXT$choices$female)),
          numericInput("age9", LBL$age, value = 40),
          numericInput("scr9", LBL$scr, value = 1),
          numericInput("ka9", LBL$ka, value = 1.0),
          numericInput("F9", LBL$bioavailability, value = 0.8),
          numericInput("CLtot9", LBL$clearance_normal, value = 6),
          numericInput("Ae9", LBL$ae, value = 0.3),
          numericInput("tau9", LBL$tau_normal, value = 24),
          numericInput("n9", LBL$number_doses, value = 10),
          
          
          tags$hr(),
          tags$h4(SEC$disease),
          numericInput("CLr_disease9", LBL$clr_disease, value = 2),
          numericInput("CLh_disease9", LBL$clh_disease, value = 1),
          numericInput("dose_disease9", LBL$dose_changed_disease, value = 250),
          numericInput("tau_disease9", LBL$tau_changed, value = 24),
          numericInput("n_disease9", LBL$changed_number_doses, value = 10),
          
          tags$hr(),
          numericInput("time9", LBL$simulation_time, value = 200),
          numericInput("effective_range_lower9", LBL$lower_bound, value = 5),
          numericInput("effective_range_upper9", LBL$upper_bound, value = 15)
        ),
        mainPanel(
          plotOutput("concentrationPlot9"),
          textOutput("BSA9"),
          textOutput("eGFR9"),
          textOutput("Ccr9"),
          textOutput("AUC9"),
          textOutput("AUC24h9"),
          textOutput("results9"),
          textOutput("crossingTimes9"),
          tags$h4(TXT$instructions$tab9_curve),
          tags$h4(TXT$instructions$tab4_step1),
          tags$h4(TXT$instructions$tab9_step2),
          tags$h4(TXT$instructions$tab9_step3),
          tags$h4(SEC$egfr),
          withMathJax(FML$bsa),
          withMathJax(FML$egfr_male),
          withMathJax(FML$egfr_female),
          tags$h4(SEC$ccr),
          withMathJax(FML$ccr_male),
          withMathJax(FML$ccr_female),
          tags$h4(SEC$pk_formula_oral_repeated),
          withMathJax(FML$oral_repeated),
          tags$h4(SEC$relation_clearance),
          withMathJax(FML$clr),
          withMathJax(FML$clh),
          withMathJax(FML$ke_clearance)
        )
      )
    )
  )
)

# ----------------------------
# server
# ----------------------------
server <- function(input, output, session) {

  # This distribution version stops the local Shiny process when the user closes the app.
  session$onSessionEnded(function() {
    try(showtext_auto(FALSE), silent = TRUE)
    stopApp()
  })
  
  # ---------------- Tab 1 ----------------
  tab1_data <- reactive({

    drug_name <- input$drug_name1
    dose <- input$dose1
    Vd <- input$V1 * input$weight1
    Time <- seq(0, input$time1, by = 0.1)
    
    ke <- switch(
      input$cl_or_ke1,
      "CLtot" = input$CLtot1 / Vd,
      "ke" = input$ke1,
      "t1/2" = t_half_to_ke(input$t_half1)
    )
    
    sim <- simulate_iv_bolus_single(dose, Vd, ke, Time)
    Cp <- sim$Cp
    AUC <- sim$AUC
    
    crossing_times <- calc_crossing_times(Time, Cp, input$effective_range_lower1)
    crossing_text <- paste("Crossing Times (lower bound):", paste(round(crossing_times, 2), collapse = ", "))
    
    AUC1_value <- {
      paste("AUC for one dose:", round(AUC, 2), "mg*hr/L")
    }

    
    results1_value <- {
      paste(
        "Dose:", input$dose1, "mg、",
        "Volume of distribution (Vd):", round(Vd, 2), "L、",
        "Body weight:", input$weight1, "kg、",
        "Elimination rate constant (ke):", round(ke, 4), "1/hr、",
        "Total clearance (CLtot):", round(ke * Vd, 2), "L/hr、",
        "Half-life (t1/2):", round(log(2) / ke, 2), "hr"
      )
    }

    
    crossingTimes1_value <- {
      crossing_text 
    }
    
    plot_value <- {
      ggplot(data.frame(Time, Cp), aes(x = Time, y = Cp)) +
            geom_line(color = "blue", linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower1, linetype = "dashed", color = "red") +
            geom_hline(yintercept = input$effective_range_upper1, linetype = "dashed", color = "red") +
            labs(
              title = paste(PLT$tab1_title, drug_name, ")", sep = ""),
              x = PLT$x_axis, y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      AUC1 = AUC1_value,
      results1 = results1_value,
      crossingTimes1 = crossingTimes1_value
    )
  })
  
  output$concentrationPlot1 <- renderPlot({
    tab1_data()$plot
  })
  
  output$AUC1 <- renderText({
    tab1_data()$AUC1
  })
  
  output$results1 <- renderText({
    tab1_data()$results1
  })
  
  output$crossingTimes1 <- renderText({
    tab1_data()$crossingTimes1
  })

  
  # ---------------- Tab 2 ----------------
  tab2_data <- reactive({

    drug_name <- input$drug_name2
    dose <- input$dose2
    Vd <- input$V2 * input$weight2
    Time <- seq(0, input$time2, by = 0.1)
    
    ke <- switch(
      input$cl_or_ke2,
      "CLtot" = input$CLtot2 / Vd,
      "ke" = input$ke2,
      "t1/2" = t_half_to_ke(input$t_half2)
    )
    
    ka <- input$ka2
    F <- input$F2
    
    sim <- simulate_oral_single(dose, Vd, ke, ka, F, Time)
    Cp <- sim$Cp
    AUC <- sim$AUC
    
    crossing_times <- calc_crossing_times(Time, Cp, input$effective_range_lower2)
    crossing_text <- paste("Crossing Times (lower bound):", paste(round(crossing_times, 2), collapse = ", "))
    
    Cmax <- max(Cp)
    Tmax <- Time[which.max(Cp)]
    
    AUC2_value <- {
      paste("AUC for one dose:", round(AUC, 2), "mg*hr/L")
    }

    
    results2_value <- {
      paste(
        "Dose:", dose, "mg、",
        "Volume of distribution (Vd):", round(Vd, 2), "L、",
        "Body weight:", input$weight2, "kg、",
        "Absorption rate constant (ka):", ka, "1/hr、",
        "Bioavailability (F):", F, "、",
        "Elimination rate constant (ke):", round(ke, 4), "1/hr、",
        "Total clearance (CLtot):", round(ke * Vd, 2), "L/hr、",
        "Half-life (t1/2):", round(log(2) / ke, 2), "hr"
      )
    }

    
    crossingTimes2_value <- {
      crossing_text 
    }

    
    CmaxTmax2_value <- {
      paste("Cmax:", round(Cmax, 2), "mg/L, Tmax:", round(Tmax, 2), "hours")
    }
    
    plot_value <- {
      ggplot(data.frame(Time, Cp), aes(x = Time, y = Cp)) +
            geom_line(color = "blue", linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower2, linetype = "dashed", color = "red") +
            geom_hline(yintercept = input$effective_range_upper2, linetype = "dashed", color = "red") +
            labs(
              title = paste(PLT$tab2_title, drug_name, ")", sep = ""),
              x = PLT$x_axis, y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      AUC2 = AUC2_value,
      results2 = results2_value,
      crossingTimes2 = crossingTimes2_value,
      CmaxTmax2 = CmaxTmax2_value
    )
  })
  
  output$concentrationPlot2 <- renderPlot({
    tab2_data()$plot
  })
  
  output$AUC2 <- renderText({
    tab2_data()$AUC2
  })
  
  output$results2 <- renderText({
    tab2_data()$results2
  })
  
  output$crossingTimes2 <- renderText({
    tab2_data()$crossingTimes2
  })
  
  output$CmaxTmax2 <- renderText({
    tab2_data()$CmaxTmax2
  })

  
  # ---------------- Tab 3 ----------------
  tab3_data <- reactive({

    drug_name <- input$drug_name3
    rate <- input$rate3
    Vd <- input$V3 * input$weight3
    Time <- seq(0, input$time3, by = 0.1)
    infusion_time <- input$infusion_time3
    
    ke <- switch(
      input$cl_or_ke3,
      "CLtot" = input$CLtot3 / Vd,
      "ke" = input$ke3,
      "t1/2" = t_half_to_ke(input$t_half3)
    )
    
    sim <- simulate_iv_infusion(rate, Vd, ke, infusion_time, Time)
    Cp <- sim$Cp
    AUC <- sim$AUC
    
    crossing_times <- calc_crossing_times(Time, Cp, input$effective_range_lower3)
    crossing_text <- paste("Crossing Times (lower bound):", paste(round(crossing_times, 2), collapse = ", "))
    
    AUC3_value <- {
      paste("AUC:", round(AUC, 2), "mg*hr/L")
    }

    
    results3_value <- {
      paste(
        "Infusion rate:", rate, "mg/hr、",
        "Volume of distribution (Vd):", round(Vd, 2), "L、",
        "Body weight:", input$weight3, "kg、",
        "Infusion time:", infusion_time, "hr、",
        "Elimination rate constant (ke):", round(ke, 4), "1/hr、",
        "Total clearance (CLtot):", round(ke * Vd, 2), "L/hr、",
        "Half-life (t1/2):", round(log(2) / ke, 2), "hr"
      )
    }

    
    crossingTimes3_value <- {
      crossing_text 
    }
    
    plot_value <- {
      ggplot(data.frame(Time, Cp), aes(x = Time, y = Cp)) +
            geom_line(color = "blue", linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower3, linetype = "dashed", color = "red") +
            geom_hline(yintercept = input$effective_range_upper3, linetype = "dashed", color = "red") +
            labs(
              title = paste(PLT$tab3_title, drug_name, ")", sep = ""),
              x = PLT$x_axis, y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      AUC3 = AUC3_value,
      results3 = results3_value,
      crossingTimes3 = crossingTimes3_value
    )
  })
  
  output$concentrationPlot3 <- renderPlot({
    tab3_data()$plot
  })
  
  output$AUC3 <- renderText({
    tab3_data()$AUC3
  })
  
  output$results3 <- renderText({
    tab3_data()$results3
  })
  
  output$crossingTimes3 <- renderText({
    tab3_data()$crossingTimes3
  })

  
  # ---------------- Tab 4 ----------------
  tab4_data <- reactive({

    drug_name <- input$drug_name4
    Time <- seq(0, input$time4, by = 0.1)
    
    dose_normal <- input$dose4
    dose_changed <- input$dose_disease4
    
    Vd <- input$V4 * input$weight4
    CLtot_normal <- input$CLtot4
    ke_normal <- CLtot_normal / Vd
    ka <- input$ka4
    F <- input$F4
    Ae <- input$Ae4
    
    CLr_normal <- CLtot_normal * Ae
    CLh_normal <- CLtot_normal - CLr_normal
    
    CLr_disease <- input$CLr_disease4
    CLh_disease <- input$CLh_disease4
    CLtot_disease <- CLr_disease + CLh_disease
    ke_disease <- CLtot_disease / Vd
    
    Cp_normal <- F * dose_normal / Vd * (ka / (ka - ke_normal)) * (exp(-ke_normal * Time) - exp(-ka * Time))
    Cp_disease <- F * dose_normal / Vd * (ka / (ka - ke_disease)) * (exp(-ke_disease * Time) - exp(-ka * Time))
    Cp_changed <- F * dose_changed / Vd * (ka / (ka - ke_disease)) * (exp(-ke_disease * Time) - exp(-ka * Time))
    
    AUC_normal <- F * dose_normal / CLtot_normal
    AUC_disease <- F * dose_normal / CLtot_disease
    AUC_changed <- F * dose_changed / CLtot_disease
    
    BSA <- 0.007184 * (input$weight4^0.425) * (input$height4^0.725)
    eGFR <- calculate_eGFR(input$scr4, input$age4, input$weight4, input$height4, input$sex4)
    Ccr <- calculate_Ccr(input$scr4, input$age4, input$weight4, input$sex4)
    
    crossing_times <- calc_crossing_times(Time, Cp_normal, input$effective_range_lower4)
    crossing_text <- paste("Crossing Times of normal curve (lower bound):", paste(round(crossing_times, 2), collapse = ", "))
    
    BSA4_value <- {
      paste("BSA:", round(BSA, 2), "m^2")
    }

    eGFR4_value <- {
      paste("eGFR:", round(eGFR, 2), "mL/min (body-surface-area-adjusted estimate)")
    }

    Ccr4_value <- {
      paste("Ccr:", round(Ccr, 2), "mL/min")
    }

    AUC4_value <- {
      paste(
        "AUC | Normal condition:", round(AUC_normal, 2),
        "mg*hr/L, Disease condition:", round(AUC_disease, 2),
        "mg*hr/L, After dose change:", round(AUC_changed, 2), "mg*hr/L"
      )
    }

    results4_value <- {
      paste(
        "Normal CLtot:", round(CLtot_normal, 2), "L/hr、",
        "Normal ke:", round(ke_normal, 4), "1/hr、",
        "Normal CLr:", round(CLr_normal, 2), "L/hr、",
        "Normal CLh:", round(CLh_normal, 2), "L/hr、",
        "Disease CLtot:", round(CLtot_disease, 2), "L/hr、",
        "Disease ke:", round(ke_disease, 4), "1/hr、",
        "Disease CLr:", round(CLr_disease, 2), "L/hr、",
        "Disease CLh:", round(CLh_disease, 2), "L/hr"
      )
    }

    crossingTimes4_value <- {
      crossing_text 
    }
    
    plot_value <- {
      df <- rbind(
            data.frame(Time = Time, Cp = Cp_normal, Condition = "Normal"),
            data.frame(Time = Time, Cp = Cp_disease, Condition = "Disease"),
            data.frame(Time = Time, Cp = Cp_changed, Condition = "Disease + Changed Dose")
          )
          
          ggplot(df, aes(x = Time, y = Cp, color = Condition)) +
            geom_line(linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower4, linetype = "dashed", color = "darkgreen") +
            geom_hline(yintercept = input$effective_range_upper4, linetype = "dashed", color = "darkgreen") +
            labs(
              title = paste(PLT$tab4_title, drug_name, ")", sep = ""),
              x = PLT$x_axis, y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      BSA4 = BSA4_value,
      eGFR4 = eGFR4_value,
      Ccr4 = Ccr4_value,
      AUC4 = AUC4_value,
      results4 = results4_value,
      crossingTimes4 = crossingTimes4_value
    )
  })
  
  output$concentrationPlot4 <- renderPlot({
    tab4_data()$plot
  })
  
  output$BSA4 <- renderText({
    tab4_data()$BSA4
  })
  
  output$eGFR4 <- renderText({
    tab4_data()$eGFR4
  })
  
  output$Ccr4 <- renderText({
    tab4_data()$Ccr4
  })
  
  output$AUC4 <- renderText({
    tab4_data()$AUC4
  })
  
  output$results4 <- renderText({
    tab4_data()$results4
  })
  
  output$crossingTimes4 <- renderText({
    tab4_data()$crossingTimes4
  })

  
  # ---------------- Tab 5 ----------------
  tab5_data <- reactive({

    drug_name <- input$drug_name5
    dose <- input$dose5
    Vd <- input$V5 * input$weight5
    Time <- seq(0, input$time5, by = 0.1)
    tau <- input$tau5
    n <- input$n5
    
    ke <- switch(
      input$cl_or_ke5,
      "CLtot" = input$CLtot5 / Vd,
      "ke" = input$ke5,
      "t1/2" = t_half_to_ke(input$t_half5)
    )
    CLtot <- ke * Vd
    
    sim <- simulate_iv_bolus_repeated(dose, Vd, ke, tau, n, Time)
    Cp <- sim$Cp
    AUC_list <- sim$AUC_list
    AUC_total <- sim$totalAUC
    AUC_24h <- calc_auc24(Time, Cp)
    Css_ave <- dose / (CLtot * tau)
    
    crossing_times <- calc_crossing_times(Time, Cp, input$effective_range_lower5)
    crossing_text <- paste("Crossing Times (lower bound):", paste(round(crossing_times, 2), collapse = ", "))
    
    AUC5_value <- {
      paste("AUC for each dose:", paste(round(AUC_list, 2), collapse = ", "), "mg*hr/L")
    }

    totalAUC5_value <- {
      paste("Total AUC:", round(AUC_total, 2), "mg*hr/L")
    }

    AUC24h5_value <- {
      paste("AUC for each 24h:", paste(round(AUC_24h, 2), collapse = ", "), "mg*hr/L")
    }

    results5_value <- {
      paste(
        "Dose:", dose, "mg、",
        "Vd:", round(Vd, 2), "L、",
        "Body weight:", input$weight5, "kg、",
        "ke:", round(ke, 4), "1/hr、",
        "CLtot:", round(CLtot, 2), "L/hr、",
        "t1/2:", round(log(2) / ke, 2), "hr、",
        "Dosing interval:", tau, "hr、",
        "Number of doses:", n, "、",
        "Effective concentration range:", input$effective_range_lower5, "-", input$effective_range_upper5, "mg/L"
      )
    }

    crossingTimes5_value <- {
      crossing_text 
    }

    CssAve5_value <- {
      paste("Average steady-state concentration (Css, ave):", round(Css_ave, 2), "mg/L")
    }
    
    plot_value <- {
      ggplot(data.frame(Time, Cp), aes(x = Time, y = Cp)) +
            geom_line(color = "blue", linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower5, linetype = "dashed", color = "red") +
            geom_hline(yintercept = input$effective_range_upper5, linetype = "dashed", color = "red") +
            labs(
              title = paste(PLT$tab5_title, drug_name, ")", sep = ""),
              x = PLT$x_axis, y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      AUC5 = AUC5_value,
      totalAUC5 = totalAUC5_value,
      AUC24h5 = AUC24h5_value,
      results5 = results5_value,
      crossingTimes5 = crossingTimes5_value,
      CssAve5 = CssAve5_value
    )
  })
  
  output$concentrationPlot5 <- renderPlot({
    tab5_data()$plot
  })
  
  output$AUC5 <- renderText({
    tab5_data()$AUC5
  })
  
  output$totalAUC5 <- renderText({
    tab5_data()$totalAUC5
  })
  
  output$AUC24h5 <- renderText({
    tab5_data()$AUC24h5
  })
  
  output$results5 <- renderText({
    tab5_data()$results5
  })
  
  output$crossingTimes5 <- renderText({
    tab5_data()$crossingTimes5
  })
  
  output$CssAve5 <- renderText({
    tab5_data()$CssAve5
  })

  
  # ---------------- Tab 6 ----------------
  tab6_data <- reactive({

    drug_name <- input$drug_name6
    initial_dose <- input$dose6_1
    changed_dose <- input$dose6_2
    initial_dose_num <- input$initial_dose_num6
    Vd <- input$V6 * input$weight6
    Time <- seq(0, input$time6, by = 0.1)
    tau <- input$tau6
    n <- input$n6
    
    ke <- switch(
      input$cl_or_ke6,
      "CLtot" = input$CLtot6 / Vd,
      "ke" = input$ke6,
      "t1/2" = t_half_to_ke(input$t_half6)
    )
    CLtot <- ke * Vd
    
    sim <- simulate_iv_bolus_repeated_changed(
      initial_dose = initial_dose,
      changed_dose = changed_dose,
      initial_dose_num = initial_dose_num,
      Vd = Vd,
      ke = ke,
      tau = tau,
      n = n,
      Time = Time
    )
    
    Cp <- sim$Cp
    AUC_list <- sim$AUC_list
    AUC_total <- sim$totalAUC
    AUC_24h <- calc_auc24(Time, Cp)
    Css_ave <- changed_dose / (CLtot * tau)
    
    crossing_times <- calc_crossing_times(Time, Cp, input$effective_range_lower6)
    crossing_text <- paste("Crossing Times (lower bound):", paste(round(crossing_times, 2), collapse = ", "))
    
    AUC6_value <- {
      paste("AUC for each dose:", paste(round(AUC_list, 2), collapse = ", "), "mg*hr/L")
    }

    totalAUC6_value <- {
      paste("Total AUC:", round(AUC_total, 2), "mg*hr/L")
    }

    AUC24h6_value <- {
      paste("AUC for each 24h:", paste(round(AUC_24h, 2), collapse = ", "), "mg*hr/L")
    }

    results6_value <- {
      paste(
        "Initial dose:", initial_dose, "mg、",
        "Changed dose:", changed_dose, "mg、",
        "Total number of doses:", n, "、",
        "Number of initial doses:", initial_dose_num, "、",
        "Vd:", round(Vd, 2), "L、",
        "ke:", round(ke, 4), "1/hr、",
        "CLtot:", round(CLtot, 2), "L/hr、",
        "t1/2:", round(log(2) / ke, 2), "hr、",
        "Dosing interval:", tau, "hr"
      )
    }

    crossingTimes6_value <- {
      crossing_text 
    }

    CssAve6_value <- {
      paste("Css, ave based on the changed dose:", round(Css_ave, 2), "mg/L")
    }
    
    plot_value <- {
      ggplot(data.frame(Time, Cp), aes(x = Time, y = Cp)) +
            geom_line(color = "blue", linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower6, linetype = "dashed", color = "red") +
            geom_hline(yintercept = input$effective_range_upper6, linetype = "dashed", color = "red") +
            labs(
              title = paste(PLT$tab6_title, drug_name, ")", sep = ""),
              x = PLT$x_axis, y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      AUC6 = AUC6_value,
      totalAUC6 = totalAUC6_value,
      AUC24h6 = AUC24h6_value,
      results6 = results6_value,
      crossingTimes6 = crossingTimes6_value,
      CssAve6 = CssAve6_value
    )
  })
  
  output$concentrationPlot6 <- renderPlot({
    tab6_data()$plot
  })
  
  output$AUC6 <- renderText({
    tab6_data()$AUC6
  })
  
  output$totalAUC6 <- renderText({
    tab6_data()$totalAUC6
  })
  
  output$AUC24h6 <- renderText({
    tab6_data()$AUC24h6
  })
  
  output$results6 <- renderText({
    tab6_data()$results6
  })
  
  output$crossingTimes6 <- renderText({
    tab6_data()$crossingTimes6
  })
  
  output$CssAve6 <- renderText({
    tab6_data()$CssAve6
  })

  
  # ---------------- Tab 7 ----------------
  tab7_data <- reactive({

    drug_name <- input$drug_name7
    dose <- input$dose7
    Vd <- input$V7 * input$weight7
    Time <- seq(0, input$time7, by = 0.1)
    tau <- input$tau7
    n <- input$n7
    ka <- input$ka7
    F <- input$F7
    
    ke <- switch(
      input$cl_or_ke7,
      "CLtot" = input$CLtot7 / Vd,
      "ke" = input$ke7,
      "t1/2" = t_half_to_ke(input$t_half7)
    )
    CLtot <- ke * Vd
    
    sim <- simulate_oral_repeated(dose, Vd, ke, ka, F, tau, n, Time)
    Cp <- sim$Cp
    AUC_list <- sim$AUC_list
    AUC_total <- sim$totalAUC
    AUC_24h <- calc_auc24(Time, Cp)
    Css_ave <- (F * dose) / (CLtot * tau)
    
    crossing_times <- calc_crossing_times(Time, Cp, input$effective_range_lower7)
    crossing_text <- paste("Crossing Times (lower bound):", paste(round(crossing_times, 2), collapse = ", "))
    
    AUC7_value <- {
      paste("AUC for each dose:", paste(round(AUC_list, 2), collapse = ", "), "mg*hr/L")
    }

    totalAUC7_value <- {
      paste("Total AUC:", round(AUC_total, 2), "mg*hr/L")
    }

    AUC24h7_value <- {
      paste("AUC for each 24h:", paste(round(AUC_24h, 2), collapse = ", "), "mg*hr/L")
    }

    results7_value <- {
      paste(
        "Dose:", dose, "mg、",
        "Vd:", round(Vd, 2), "L、",
        "Body weight:", input$weight7, "kg、",
        "ka:", ka, "1/hr、",
        "F:", F, "、",
        "ke:", round(ke, 4), "1/hr、",
        "CLtot:", round(CLtot, 2), "L/hr、",
        "t1/2:", round(log(2) / ke, 2), "hr、",
        "Dosing interval:", tau, "hr、",
        "Number of doses:", n
      )
    }

    crossingTimes7_value <- {
      crossing_text 
    }

    CssAve7_value <- {
      paste("Average steady-state concentration (Css, ave):", round(Css_ave, 2), "mg/L")
    }
    
    plot_value <- {
      ggplot(data.frame(Time, Cp), aes(x = Time, y = Cp)) +
            geom_line(color = "blue", linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower7, linetype = "dashed", color = "red") +
            geom_hline(yintercept = input$effective_range_upper7, linetype = "dashed", color = "red") +
            labs(
              title = paste(PLT$tab7_title, drug_name, ")", sep = ""),
              x = PLT$x_axis, y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      AUC7 = AUC7_value,
      totalAUC7 = totalAUC7_value,
      AUC24h7 = AUC24h7_value,
      results7 = results7_value,
      crossingTimes7 = crossingTimes7_value,
      CssAve7 = CssAve7_value
    )
  })
  
  output$concentrationPlot7 <- renderPlot({
    tab7_data()$plot
  })
  
  output$AUC7 <- renderText({
    tab7_data()$AUC7
  })
  
  output$totalAUC7 <- renderText({
    tab7_data()$totalAUC7
  })
  
  output$AUC24h7 <- renderText({
    tab7_data()$AUC24h7
  })
  
  output$results7 <- renderText({
    tab7_data()$results7
  })
  
  output$crossingTimes7 <- renderText({
    tab7_data()$crossingTimes7
  })
  
  output$CssAve7 <- renderText({
    tab7_data()$CssAve7
  })

  
  # ---------------- Tab 8 ----------------
  tab8_data <- reactive({

    Time <- seq(0, input$time8, by = 0.1)
    
    # Condition 1
    drug_name1 <- input$drug_name8_1
    dose1 <- input$dose8_1
    Vd1 <- input$V8_1 * input$weight8_1
    tau1 <- input$tau8_1
    n1 <- input$n8_1
    ka1 <- input$ka8_1
    F1 <- input$F8_1
    
    ke1 <- switch(
      input$cl_or_ke8_1,
      "CLtot" = input$CLtot8_1 / Vd1,
      "ke" = input$ke8_1,
      "t1/2" = t_half_to_ke(input$t_half8_1)
    )
    CLtot1 <- ke1 * Vd1
    
    sim1 <- simulate_oral_repeated(dose1, Vd1, ke1, ka1, F1, tau1, n1, Time)
    Cp1 <- sim1$Cp
    AUC_list1 <- sim1$AUC_list
    AUC_total1 <- sim1$totalAUC
    AUC_24h_1 <- calc_auc24(Time, Cp1)
    Css_ave1 <- (F1 * dose1) / (CLtot1 * tau1)
    
    # Condition 2
    drug_name2 <- input$drug_name8_2
    dose2 <- input$dose8_2
    Vd2 <- input$V8_2 * input$weight8_2
    tau2 <- input$tau8_2
    n2 <- input$n8_2
    ka2 <- input$ka8_2
    F2 <- input$F8_2
    
    ke2 <- switch(
      input$cl_or_ke8_2,
      "CLtot" = input$CLtot8_2 / Vd2,
      "ke" = input$ke8_2,
      "t1/2" = t_half_to_ke(input$t_half8_2)
    )
    CLtot2 <- ke2 * Vd2
    
    sim2 <- simulate_oral_repeated(dose2, Vd2, ke2, ka2, F2, tau2, n2, Time)
    Cp2 <- sim2$Cp
    AUC_list2 <- sim2$AUC_list
    AUC_total2 <- sim2$totalAUC
    AUC_24h_2 <- calc_auc24(Time, Cp2)
    Css_ave2 <- (F2 * dose2) / (CLtot2 * tau2)
    
    crossing_times1 <- calc_crossing_times(Time, Cp1, input$effective_range_lower8)
    crossing_times2 <- calc_crossing_times(Time, Cp2, input$effective_range_lower8)
    
    crossingTimes8_value <- {
      paste0(
        "Crossing times (lower bound), Condition 1: ",
        paste(round(crossing_times1, 2), collapse = ", "),
        " / Condition 2: ",
        paste(round(crossing_times2, 2), collapse = ", ")
      )
    }

    
    AUC8_1_value <- {
      paste("Condition 1 AUC for each dose:", paste(round(AUC_list1, 2), collapse = ", "), "mg*hr/L")
    }

    totalAUC8_1_value <- {
      paste("Condition 1 total AUC:", round(AUC_total1, 2), "mg*hr/L")
    }

    AUC24h8_1_value <- {
      paste("Condition 1 AUC for each 24 h:", paste(round(AUC_24h_1, 2), collapse = ", "), "mg*hr/L")
    }

    CssAve8_1_value <- {
      paste("Condition 1 Css, ave:", round(Css_ave1, 2), "mg/L")
    }

    results8_1_value <- {
      paste(
        "Condition 1 | Dose:", dose1, "mg、",
        "Vd:", round(Vd1, 2), "L、",
        "Body weight:", input$weight8_1, "kg、",
        "ka:", ka1, "1/hr、",
        "F:", F1, "、",
        "ke:", round(ke1, 4), "1/hr、",
        "CLtot:", round(CLtot1, 2), "L/hr、",
        "t1/2:", round(log(2) / ke1, 2), "hr、",
        "τ:", tau1, "hr、",
        "Number of doses:", n1
      )
    }

    
    AUC8_2_value <- {
      paste("Condition 2 AUC for each dose:", paste(round(AUC_list2, 2), collapse = ", "), "mg*hr/L")
    }

    totalAUC8_2_value <- {
      paste("Condition 2 total AUC:", round(AUC_total2, 2), "mg*hr/L")
    }

    AUC24h8_2_value <- {
      paste("Condition 2 AUC for each 24 h:", paste(round(AUC_24h_2, 2), collapse = ", "), "mg*hr/L")
    }

    CssAve8_2_value <- {
      paste("Condition 2 Css, ave:", round(Css_ave2, 2), "mg/L")
    }

    results8_2_value <- {
      paste(
        "Condition 2 | Dose:", dose2, "mg、",
        "Vd:", round(Vd2, 2), "L、",
        "Body weight:", input$weight8_2, "kg、",
        "ka:", ka2, "1/hr、",
        "F:", F2, "、",
        "ke:", round(ke2, 4), "1/hr、",
        "CLtot:", round(CLtot2, 2), "L/hr、",
        "t1/2:", round(log(2) / ke2, 2), "hr、",
        "τ:", tau2, "hr、",
        "Number of doses:", n2
      )
    }
    
    plot_value <- {
      plot_df <- rbind(
            data.frame(Time = Time, Cp = Cp1, Condition = paste0("Condition 1: ", drug_name1)),
            data.frame(Time = Time, Cp = Cp2, Condition = paste0("Condition 2: ", drug_name2))
          )
          
          ggplot(plot_df, aes(x = Time, y = Cp, color = Condition)) +
            geom_line(linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower8, linetype = "dashed", color = "darkgreen") +
            geom_hline(yintercept = input$effective_range_upper8, linetype = "dashed", color = "darkgreen") +
            labs(
              title = TXT$tabs$tab8,
              x = PLT$x_axis,
              y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      crossingTimes8 = crossingTimes8_value,
      AUC8_1 = AUC8_1_value,
      totalAUC8_1 = totalAUC8_1_value,
      AUC24h8_1 = AUC24h8_1_value,
      CssAve8_1 = CssAve8_1_value,
      results8_1 = results8_1_value,
      AUC8_2 = AUC8_2_value,
      totalAUC8_2 = totalAUC8_2_value,
      AUC24h8_2 = AUC24h8_2_value,
      CssAve8_2 = CssAve8_2_value,
      results8_2 = results8_2_value
    )
  })
  
  output$concentrationPlot8 <- renderPlot({
    tab8_data()$plot
  })
  
  output$crossingTimes8 <- renderText({
    tab8_data()$crossingTimes8
  })
  
  output$AUC8_1 <- renderText({
    tab8_data()$AUC8_1
  })
  
  output$totalAUC8_1 <- renderText({
    tab8_data()$totalAUC8_1
  })
  
  output$AUC24h8_1 <- renderText({
    tab8_data()$AUC24h8_1
  })
  
  output$CssAve8_1 <- renderText({
    tab8_data()$CssAve8_1
  })
  
  output$results8_1 <- renderText({
    tab8_data()$results8_1
  })
  
  output$AUC8_2 <- renderText({
    tab8_data()$AUC8_2
  })
  
  output$totalAUC8_2 <- renderText({
    tab8_data()$totalAUC8_2
  })
  
  output$AUC24h8_2 <- renderText({
    tab8_data()$AUC24h8_2
  })
  
  output$CssAve8_2 <- renderText({
    tab8_data()$CssAve8_2
  })
  
  output$results8_2 <- renderText({
    tab8_data()$results8_2
  })

  

  # ---------------- Tab 9 ----------------
  tab9_data <- reactive({

    drug_name <- input$drug_name9
    Time <- seq(0, input$time9, by = 0.1)
    
    # Normal condition
    dose_normal <- input$dose9
    Vd <- input$V9 * input$weight9
    CLtot_normal <- input$CLtot9
    ke_normal <- CLtot_normal / Vd
    ka <- input$ka9
    F <- input$F9
    Ae <- input$Ae9
    tau_normal <- input$tau9
    
    CLr_normal <- CLtot_normal * Ae
    CLh_normal <- CLtot_normal - CLr_normal
    
    # Disease condition
    CLr_disease <- input$CLr_disease9
    CLh_disease <- input$CLh_disease9
    CLtot_disease <- CLr_disease + CLh_disease
    ke_disease <- CLtot_disease / Vd
    
    dose_changed <- input$dose_disease9
    tau_disease <- input$tau_disease9
    
    # Determine the number of doses automatically from the simulation time
    n_normal <- floor(input$time9 / tau_normal) + 1
    n_disease <- floor(input$time9 / tau_normal) + 1
    n_changed <- floor(input$time9 / tau_disease) + 1
    
    # Calculate concentrations
    sim_normal <- simulate_oral_repeated(dose_normal, Vd, ke_normal, ka, F, tau_normal, n_normal, Time)
    Cp_normal <- sim_normal$Cp
    AUC_total_normal <- sim_normal$totalAUC
    AUC24_normal <- calc_auc24(Time, Cp_normal)
    
    sim_disease <- simulate_oral_repeated(dose_normal, Vd, ke_disease, ka, F, tau_normal, n_disease, Time)
    Cp_disease <- sim_disease$Cp
    AUC_total_disease <- sim_disease$totalAUC
    AUC24_disease <- calc_auc24(Time, Cp_disease)
    
    sim_changed <- simulate_oral_repeated(dose_changed, Vd, ke_disease, ka, F, tau_disease, n_changed, Time)
    Cp_changed <- sim_changed$Cp
    AUC_total_changed <- sim_changed$totalAUC
    AUC24_changed <- calc_auc24(Time, Cp_changed)
    
    # eGFR, Ccr, BSA
    BSA <- 0.007184 * (input$weight9^0.425) * (input$height9^0.725)
    eGFR <- calculate_eGFR(input$scr9, input$age9, input$weight9, input$height9, input$sex9)
    Ccr <- calculate_Ccr(input$scr9, input$age9, input$weight9, input$sex9)
    
    # crossing time
    crossing_times <- calc_crossing_times(Time, Cp_normal, input$effective_range_lower9)
    crossing_text <- paste("Crossing Times of normal curve (lower bound):", paste(round(crossing_times, 2), collapse = ", "))
    
    BSA9_value <- {
      paste("BSA:", round(BSA, 2), "m^2")
    }

    
    eGFR9_value <- {
      paste("eGFR:", round(eGFR, 2), "mL/min (body-surface-area-adjusted estimate)")
    }

    
    Ccr9_value <- {
      paste("Ccr:", round(Ccr, 2), "mL/min")
    }

    

    
    AUC9_value <- {
      paste(
        "Total AUC | Normal condition:", round(AUC_total_normal, 2), "mg*hr/L, ",
        "Disease condition:", round(AUC_total_disease, 2), "mg*hr/L, ",
        "After regimen change:", round(AUC_total_changed, 2), "mg*hr/L"
      )
    }

    
    AUC24h9_value <- {
      paste(
        "AUC for each 24 h | Normal condition:", paste(round(AUC24_normal, 2), collapse = ", "),
        " / Disease condition:", paste(round(AUC24_disease, 2), collapse = ", "),
        " / After regimen change:", paste(round(AUC24_changed, 2), collapse = ", ")
      )
    }

    
    results9_value <- {
      paste(
        "Normal CLtot:", round(CLtot_normal, 2), "L/hr、",
        "Normal ke:", round(ke_normal, 4), "1/hr、",
        "Normal CLr:", round(CLr_normal, 2), "L/hr、",
        "Normal CLh:", round(CLh_normal, 2), "L/hr、",
        "Normal τ:", round(tau_normal, 2), "hr || ",
        "Disease CLtot:", round(CLtot_disease, 2), "L/hr、",
        "Disease ke:", round(ke_disease, 4), "1/hr、",
        "Disease CLr:", round(CLr_disease, 2), "L/hr、",
        "Disease CLh:", round(CLh_disease, 2), "L/hr、",
        "Changed dose, disease condition:", round(dose_changed, 2), "mg、",
        "Changed τ, disease condition:", round(tau_disease, 2), "hr"
      )
    }

    
    crossingTimes9_value <- {
      crossing_text
    }
    
    plot_value <- {
      df <- rbind(
            data.frame(Time = Time, Cp = Cp_normal, Condition = "Normal"),
            data.frame(Time = Time, Cp = Cp_disease, Condition = "Disease"),
            data.frame(Time = Time, Cp = Cp_changed, Condition = "Disease + Changed")
          )
          
          ggplot(df, aes(x = Time, y = Cp, color = Condition)) +
            geom_line(linewidth = 1.2) +
            geom_hline(yintercept = input$effective_range_lower9, linetype = "dashed", color = "darkgreen") +
            geom_hline(yintercept = input$effective_range_upper9, linetype = "dashed", color = "darkgreen") +
            labs(
              title = paste(PLT$tab9_title, drug_name, ")", sep = ""),
              x = PLT$x_axis,
              y = PLT$y_axis
            ) +
            theme_bw(base_size = 18)
    }
    
    list(
      plot = plot_value,
      BSA9 = BSA9_value,
      eGFR9 = eGFR9_value,
      Ccr9 = Ccr9_value,
      AUC9 = AUC9_value,
      AUC24h9 = AUC24h9_value,
      results9 = results9_value,
      crossingTimes9 = crossingTimes9_value
    )
  })
  
  output$concentrationPlot9 <- renderPlot({
    tab9_data()$plot
  })
  
  output$BSA9 <- renderText({
    tab9_data()$BSA9
  })
  
  output$eGFR9 <- renderText({
    tab9_data()$eGFR9
  })
  
  output$Ccr9 <- renderText({
    tab9_data()$Ccr9
  })
  
  output$AUC9 <- renderText({
    tab9_data()$AUC9
  })
  
  output$AUC24h9 <- renderText({
    tab9_data()$AUC24h9
  })
  
  output$results9 <- renderText({
    tab9_data()$results9
  })
  
  output$crossingTimes9 <- renderText({
    tab9_data()$crossingTimes9
  })

  
}

# ----------------------------
# Run App
# ----------------------------

# Remove the showtext graphics hook when the app stops.
onStop(function() {
  try(showtext_auto(FALSE), silent = TRUE)
})

shinyApp(ui = ui, server = server)
