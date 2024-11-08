################################################################################
################################################################################
################################################################################
###################### Laratory Reference Interval tool ########################
######################           (LabRI tool)           ########################
################################################################################
################################################################################
############################ (CLICK on "Run App") ##############################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################


################################################################################
####################### Lista de pacotes necessários ###########################
################################################################################

if (!require("pacman")) install.packages("pacman")

pacman::p_load("AID", "DT", "FactoMineR", "KernSmooth", "MASS", "MethComp",
               "RVAideMemoire", "calibrate", "cartography", "cluster", "datawizard",
               "data.table", "devtools", "digest", "dplyr", "epiR", "factoextra",
               "ffp", "forecast", "ggQC", "ggplot2", "ggpubr", "ggtext", "grid", "gt",
               "imputeTS", "installr", "irr", "janitor", "kableExtra", "knitr",
               "lattice", "lubridate", "mclust", "mixR", "modeest", "moments",
               "multimode", "multiway", "nortest", "openxlsx", "plotly",
               "prettydoc", "qqplotr", "readr", "readxl", "refineR", "reflimR",
               "reshape2", "rmarkdown", "scales", "stats", "stringi", "systemfonts",
               "tools", "utf8", "univOutl", "xfun", "writexl", "zlog",
               "shinythemes","shiny")

################################################################################
############## Função para carregar ou criar dados padrão ######################
################################################################################

load_or_initialize_data <- function() {
  if (!dir.exists("3_Exported_dataset_and_figures")) {
    dir.create("3_Exported_dataset_and_figures")
  }
  
  params_file <- file.path("3_Exported_dataset_and_figures", "saved_params.Rds")
  
  if (file.exists(params_file)) {
    readRDS(params_file)
  } else {
    list(
      file_name = "",
      column_name = "",
      ri_type = "Double-sided",
      decimal_places = "2",
      responsible_person = "",
      measurement_procedure = "",
      measurand_name = "",
      name_of_measurand = "",
      unit = "",
      specimen = "",
      age_range = "",
      sex = "",
      exclusion_criteria = "",
      data_source = "",
      upper_ref_limit = "",
      lower_ref_limit = "",
      comp_ref_source = "",
      max_sample_size = "10000"
    )
  }
}

saved_params <- load_or_initialize_data()

################################################################################
########################## Interface do usuário (UI) ###########################
################################################################################

ui <- fluidPage(
  theme = shinytheme("flatly"),

  
  
  # Container principal para o cabeçalho do aplicativo
  
  tags$div(
    
    # Estilo do container principal, incluindo o fundo com gradiente e o layout flexbox para organizar os elementos
    
    style = "background: linear-gradient(to bottom, #062d79, #4a7ad8); padding: 15px; display: flex; align-items: center; justify-content: space-between; height: 140px; 
           border: 2px solid #000000; border-radius: 5px;",
    
    # Sub-div para o logo, agora alinhado à esquerda do título e subtítulo
    
    tags$div(
      
      # Estilo para ajustar o espaçamento e alinhamento do logo
      
      style = "padding-right: 20px; display: flex; align-items: center;",  # padding-right adiciona espaço entre o logo e o título/subtítulo, e align-items centra o logo verticalmente
      img(src = "logo.png", alt = "Logo", 
          style = "height: 135px; margin-bottom: 6px; margin-top: 10px;")  # Ajuste o valor de 'margin-top' para posicionar a imagem verticalmente conforme desejado
    ),
    
    # Sub-div para o título e subtítulo
    
    tags$div(
      # Estilo para alinhar o título e subtítulo à esquerda e ocupar o espaço disponível (flex-grow: 1)
      style = "text-align: left; flex-grow: 1;",
      
      # Título principal do aplicativo
   
      h1("Laboratory Reference Interval (LabRI) Tool", 
         style = "color: white; margin: 0;"),  # Cor branca para o texto e sem margens extras para alinhar ao topo
      
      # Subtítulo abaixo do título principal
      
      tags$p("Tool for Estimating and Verifying Reference Intervals", 
             style = "color: #d1d1d1; margin: 5px 0 0 0; font-size: 18px;")  # Cor cinza clara para diferenciar do título e tamanho de fonte menor
    )
  ),
  

  # Estilo customizado para as abas
  
  tags$style(HTML("
    .nav-tabs > li > a {
      color: #000000; /* Cor da letra para aba selecionada */
      background-color: #fffcc4; /* Cor amerelo pastel para as abas não selecionadas */
    }
    .nav-tabs > li.active > a, .nav-tabs > li.active > a:hover, .nav-tabs > li.active > a:focus {
      color: white;   /* Cor da letra para aba selecionada */
      background-color: #0d47a1; /* Cor azul escuro escuro para a aba selecionada */
    }
  ")),


  # Tabset Panel para adicionar abas
  
  tabsetPanel(id = "tabs",
              tabPanel("Configuration",
                       sidebarLayout(
                         sidebarPanel(
                           width = 9, # Ajuste a largura para 8 colunas
                           style = "background-color: #f8f9fa; border: 1px solid #ddd; padding: 15px;",
                           
                           
                           tags$h2("Name of the responsible specialist", style = "color: #4878d5; margin-top: 25px;margin-bottom: 25px;"),
                           textInput("responsible_person", "Specialist responsible for data analysis:", 
                                     saved_params$responsible_person, width = '100%'),
                           tags$p(tags$strong("NOTE 1:")," Provide the name of the person responsible for the process or analysis performed.", style = "font-size: 12px; color: #666; margin-top: -10px; margin-bottom: 20px;"),
                           tags$hr(style = "border-top: 3px solid #4878d5; margin: 15px 0;"),
                           
                           
                           tags$h2("Define the Dataset", style = "color: #4878d5; margin-top: 25px;margin-bottom: 25px;"),
                           fileInput("file_name", 
                                     label = tags$span("File Name:", style = "font-weight: bold; font-size: 16px;"), 
                                     accept = c(".csv", ".xls", ".xlsx"), 
                                     width = '100%', 
                                     buttonLabel = tags$span("Click here to Choose File", style = "font-size: 14px; color: white;"),
                                     placeholder = "No file selected"),
                           
                           tags$p(tags$strong("NOTE 2:")," Select the data file to be analyzed. The file must be in .csv, .xls, or .xlsx format.", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -15px; margin-bottom: 25px;"),

                           selectInput("column_name", "Column Name:", choices = NULL, width = '100%'),
                           tags$p(tags$strong("NOTE 3:")," Select the column name from the dropdown list containing the data to be analyzed.", style = "font-size: 12px; color: #666); text-align: justify; margin-top: -10px; margin-bottom: 25px;"),

                           radioButtons("measurand_name", 
                                        "Is the measurand name the same as the column name?", 
                                        choices = c("Yes" = "Yes", "No" = "No"), 
                                        selected = saved_params$measurand_name),
                           conditionalPanel(
                             condition = "input.measurand_name == 'No'",
                             
                             
                             textInput("name_of_measurand", 
                                       "Measurand Name (if different from the column name):", 
                                       saved_params$name_of_measurand, width = '100%')),
                           tags$p(tags$strong("NOTE 4:")," Select 'Yes' if the measurand name is the same as the column name in the dataset, or 'No' otherwise. If 'No' is selected, an additional field will appear to specify a custom measurand name, which will be used in the HTML report generated by the tool.", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"),
                           
                           
                           textInput("data_source", 
                                     "Data Source:", 
                                     saved_params$data_source, 
                                     width = '100%'),
                           tags$p(tags$strong("NOTA 5:")," Provide the data source, specifying where the dataset was obtained from.", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"),
                           tags$hr(style = "border-top: 3px solid #4878d5; margin: 15px 0;"),
                           
                           
                           
                           radioButtons("ri_type", 
                                        "Type of Reference Interval:", 
                                        choices = c("Double-sided", "Right-sided"), 
                                        selected = saved_params$ri_type),
                           tags$p(tags$strong("NOTE 6:")," Select the desired type of reference interval. The default setting is 'Double-sided,' which calculates both the lower and upper reference limits. 'Right-sided' considers only the upper reference limit.", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"),
                           
                           numericInput("decimal_places", "Decimal Places:", 
                                        saved_params$decimal_places, min = 0),
                           tags$p(tags$strong("NOTE 7:")," Provide the desired number of decimal places for the results. If left blank, the default value will be 2 decimal places.", style = "font-size: 12px; color: #666; margin-top: -10px; margin-bottom: 25px;"),
                           tags$hr(style = "border-top: 3px solid #4878d5; margin: 15px 0;"),
                           
                           
                           tags$h2("Information for Study Traceability", style = "color: #4878d5; margin-top: 25px;margin-bottom: 25px;"),
                           textAreaInput("measurement_procedure", 
                                         "Measurement Procedure and Analytical Method:", 
                                         saved_params$measurement_procedure, width = '100%', 
                                         height = '100px'),
                           tags$p(tags$strong("NOTA 8:")," Describe the measurement procedure and the analytical method used. This method is the practical process that applies the analytical principle to obtain the result.", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"),


                           textInput("unit", "Unit of Measurement:", 
                                     saved_params$unit, width = '100%'),
                           tags$p(tags$strong("NOTE 9:")," Describe the unit of measurement for the measurand (e.g., mg/dL, g/dL, mmol/L etc.).", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"),

                           textInput("specimen", "Sample Type:", 
                                     saved_params$specimen, width = '100%'),
                           tags$p(tags$strong("NOTE 10:")," Describe the sample type (e.g., whole blood, serum, plasma, 24-hour urine, random urine etc.).", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"),

                           textInput("age_range", "Age Range:", saved_params$age_range, 
                                     width = '100%'),
                           tags$p(tags$strong("NOTE 11:")," Describe the age range concisely to ensure readability in the HTML report. Suggested formats for reporting the age range include simple, direct expressions like '7 to 16 years', 'under 2 years', '7 - 16 years', '< 2 years' etc.", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"),

                           textInput("sex", "Sex:", 
                                     saved_params$sex, width = '100%'),
                           tags$p(tags$strong("NOTE 12:")," Describe the sex concisely to ensure readability in the HTML report. Suggested formats include simple, direct expressions like 'Male', 'Female', 'M,' 'F', 'Male and Female', 'M and F' etc.", style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"),

                           textAreaInput("exclusion_criteria", 
                                         "Exclusion Criteria:", 
                                         saved_params$exclusion_criteria, 
                                         width = '100%', height = '100px'),
                           tags$div(
                             tags$p(tags$strong("NOTE 13:"), " Defining exclusion criteria is essential to ensure that reference intervals accurately represent the healthy population. In direct methods, these criteria enable the careful selection of reference individuals by eliminating factors that could introduce unwanted variability, such as recent illnesses or medication use.",
                                    style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 15px;"
                             ),
                             tags$p("In the indirect sampling method, filtering the dataset is essential. Exclusion criteria should be applied, such as:",
                                    style = "font-size: 12px; color: #666; text-align: justify; margin-top: -5px; margin-bottom: 10px;"
                             ),
                             tags$ul(
                               tags$li(tags$strong("Exclude potentially pathological results:"), 
                                       " Eliminate values that may skew the reference distribution, ensuring it represents healthy individuals. To increase dataset selectivity, abnormal results from co-requested laboratory tests can be used to help identify subclinical conditions. Additionally, methods like Latent Abnormal Values Exclusion (LAVE) or similar approaches allow for iterative exclusion of latent abnormal values, refining the dataset more precisely.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Remove data from specific departments (e.g., oncology, Intensive Care Unit, Home Care etc):"),
                                       " These departments typically handle patients in critical conditions that can significantly alter results.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Limit the frequency of results per patient within the study period:"),
                                       " Including, for example, only the first result for each patient prevents data overload from the same individual, which could bias the sample.",
                                       style = "margin-bottom: 10px;"
                               )
                             ),
                             style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"
                           ),
                           tags$hr(style = "border-top: 3px solid #4878d5; margin: 15px 0;")
                           ,

                           
                           
                           tags$h2("Provide the Comparative Reference Interval (if applicable)", style = "color: #4878d5; margin-top: 25px;margin-bottom: 25px;"),
                           numericInput("upper_ref_limit", 
                                        "Upper Reference Limit of the Comparative Reference:",
                                        saved_params$upper_ref_limit, 
                                        width = '100%'),
                           numericInput("lower_ref_limit", 
                                        "Lower Reference Limit of the Comparative Reference:", 
                                        saved_params$lower_ref_limit,
                                        width = '100%'),
                           textAreaInput("comp_ref_source", 
                                         "Source of the Comparative Reference:", 
                                         saved_params$comp_ref_source, 
                                         width = '100%', 
                                         height = '100px'),
                           tags$div(
                             tags$p(tags$strong("NOTe 14:"), "To perform reference interval verification, a comparative reference interval must be provided. This comparative reference interval can be selected from various sources, such as:",
                                    style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 15px;"
                             ),
                             tags$ul(
                               tags$li(tags$strong("Reagent Kit Package Inserts: "), 
                                       " Specified reference ranges for laboratory tests based on manufacturer's validation studies.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Scientific publications and guidelines from specialized organizations: "), 
                                       "Intervals derived from multicenter studies and reviews that reflect widely accepted practices in the field.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Academic Books (Textbooks): "), 
                                       "Consolidated and widely accepted reference intervals based on extensive scientific literature and available in academic books.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Local or multicentric studies: "), 
                                       "Results obtained for a specific population or harmonized across multiple regions.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Indirect methods: "), 
                                       "  involve previous studies that estimated reference intervals using patient data stored in laboratory information systems (LIS), applying algorithms to identify and exclude potentially pathological values.",
                                       style = "margin-bottom: 10px;"
                               )
                             ),
                             style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"
                           ),
                           tags$p(
                             tags$strong("NOTE 15:")," If a Comparative Reference Interval is not specified, the reference interval estimated by the LabRI method itself will be used as the comparative reference. This is because the verification module algorithms of the LabRI method require a comparative reference to perform the verification.", 
                             style = "font-size: 12px; color: #666; text-align: justify; margin-top: -10px; margin-bottom: 25px;"
                           ),
                           tags$hr(style = "border-top: 3px solid #4878d5; margin: 15px 0;"),
                           
                           
                           
                           tags$h2("Define the sampling method used for the study (if applicable)", style = "color: #4878d5; margin-top: 25px;margin-bottom: 25px;"),
                           numericInput("max_sample_size", 
                                        "Maximum Sample Size:", 
                                        saved_params$max_sample_size),
                           tags$p(tags$strong("NOTE 15:"), " If the maximum sample size is not specified, a default value of 10,000 will be used. This value was validated in the LabRI method study to estimate reference intervals that are representative of the population served by the laboratory, ensuring processing efficiency and timely results.", 
                                  style = "font-size: 12px; color: #666; margin-top: -10px; margin-bottom: 25px; text-align: justify;"),
                           tags$hr(style = "border-top: 3px solid #4878d5; margin: 15px 0;"),
                           
                           
                           
                           tags$h2("Main Commands", style = "color: #4878d5; margin-top: 25px;margin-bottom: 25px;"),
                           # Botões em nova ordem
                           actionButton("save_config", "Save Configuration", 
                                        style = "background-color: #0d47a1; color: white; border: 2px solid #0a397f;
                                        font-weight: bold; box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3); 
                                        border-top-color: #1a5bb5; border-left-color: #1a5bb5;"),
                           
                           actionButton("clear_config", "Clear Configuration", style = "background-color: #fffcc4; color: black; 
                           border: 2px solid #e1b12c; font-weight: bold; box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3); 
                                        border-top-color: #ffffe0; border-left-color: #ffffe0;"),
                           
                           actionButton("generate_report", "Generate Report", style = "background-color: #31a939; color: white; 
                           border: 2px solid #228b22; font-weight: bold; box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
                                        border-top-color: #4caf50; border-left-color: #4caf50;"),
                          tags$hr(style = "border-top: 3px solid #4878d5; margin: 15px 0;"), 
                          
                          
                          tags$h2("Report an Issue", style = "color: #4878d5; margin-top: 25px; margin-bottom: 25px;"),
                          tags$p(
                            "Did you encounter any issues with the LabRI Tool? We appreciate your feedback! To report a problem, click the link below to access our issues system on GitHub:",
                            tags$a(
                              tags$span("Report an Issue in GitHub", style = "text-align: justify; margin-right: 5px;"),
                              tags$img(src = "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png", 
                                       alt = "GitHub", 
                                       style = "width: 20px; height: 20px; vertical-align: middle;"),
                              href = "https://github.com/labrgrupo/LabRI_Tool/issues/new/choose",
                              target = "_blank", 
                              style = "color: #0d47a1; font-weight: bold; text-decoration: none; display: inline-flex; align-items: center;"
                            ),
                            tags$p(
                              tags$strong("NOTE 16:"), " To submit an issue report, you need to have a GitHub account and be logged in.",
                              style = "font-size: 12px; color: #666; text-align: justify; margin-top: 10px;"
                            )),
                          
                          tags$hr(style = "border-top: 3px solid #4878d5; margin: 15px 0;"),
                          ),

                         mainPanel(
                           uiOutput("report_view"),
                           style = "background-color: #ffffff; padding: 20px; border-radius: 5px;"
                         )
                       )
              ),
              # Aba para o relatório
              
              tabPanel("Report", 
                       value = "relatorio", 
                       uiOutput("report_content"))
              ),

  
  
  # Nota de rodapé
  
tags$footer(
  tags$p(
    "Developed by Alan Carvalho Dias | Powered by LabR Group  | License: GPL-3.0  | Code available at: ",

    # Ícone do GitHub com o texto abaixo do ícone
    
    tags$a(
      href = "https://github.com/labrgrupo/site_labrgroup",
      target = "_blank",
      style = "color: white; text-decoration: none; display: inline-flex; flex-direction: column; align-items: center; margin-left: 10px;",
      
      icon("github", style = "font-size: 24px;"),  # Ícone do GitHub
      tags$span("GitHub", style = "font-size: 12px;")  # Texto abaixo do ícone
    ),
    
    # Ícone do site com link
    tags$a(
      href = "https://grupolabr.com/LabRI_Packed",  # Substitua com o link do site oficial do grupo Lab R
      target = "_blank",
      style = "color: white; text-decoration: none; display: inline-flex; flex-direction: column; align-items: center; margin-left: 10px;",
      
      icon("globe", style = "font-size: 24px;"),  # Ícone de globo para o site
      tags$span("Lab R Group Website", style = "font-size: 12px;")  # Texto abaixo do ícone
    ),
    
  ),
  style = "background: linear-gradient(to bottom, #4a7ad8, #062d79); color: white; padding: 15px; text-align: center; border-top: 1px solid #ddd; margin-top: 20px;"
),
)


################################################################################
######################### Função para salvar os parâmetros atuais ##############
################################################################################


save_params <- function(input) {
  params_file <- file.path("3_Exported_dataset_and_figures", "saved_params.Rds")
  saveRDS(list(
    file_name = input$file_name$name,
    column_name = input$column_name,
    ri_type = input$ri_type,
    decimal_places = input$decimal_places,
    responsible_person = input$responsible_person,
    measurement_procedure = input$measurement_procedure,
    measurand_name = input$measurand_name,
    name_of_measurand = input$name_of_measurand,
    unit = input$unit,
    specimen = input$specimen,
    age_range = input$age_range,
    sex = input$sex,
    exclusion_criteria = input$exclusion_criteria,
    data_source = input$data_source,
    upper_ref_limit = input$upper_ref_limit,
    lower_ref_limit = input$lower_ref_limit,
    comp_ref_source = input$comp_ref_source,
    max_sample_size = input$max_sample_size
  ), params_file)
}

# Função para limpar os parâmetros salvos

clear_saved_params <- function() {
  params_file <- file.path("3_Exported_dataset_and_figures", "saved_params.Rds")
  if (file.exists(params_file)) {
    file.remove(params_file)
  }
}

################################################################################
########################## Server para o Shiny App #############################
################################################################################


server <- function(input, output, session) {
  
  # Define o diretório onde o relatório será salvo
  
  output_dir <- "5_Output_Report"
  
  # Cria um caminho acessível no Shiny para o diretório onde o relatório é salvo
  
  addResourcePath("report", output_dir)
  
  # Função reativa para carregar o arquivo e ler as colunas
  
  dataset <- reactive({
    req(input$file_name)
    ext <- tools::file_ext(input$file_name$name)
    file_path <- input$file_name$datapath
    
    # Lê o arquivo com base na extensão
    if (ext == "csv") {
      data <- read.csv(file_path)
    } else if (ext %in% c("xls", "xlsx")) {
      data <- readxl::read_excel(file_path)
    } else {
      showModal(modalDialog(
        title = "Erro",
        "Formato de arquivo não suportado.",
        easyClose = TRUE,
        footer = NULL
      ))
      return(NULL)
    }
    
    data
  })
  
  # Observador para atualizar a lista de colunas com nomes no selectInput
  
  observe({
    data <- dataset()
    if (!is.null(data)) {
      col_names <- names(data)
      updateSelectInput(session, "column_name", choices = col_names)
    }
  })
  
  # Observador para salvar configuração
  
  observeEvent(input$save_config, {
    save_params(input)
    showModal(modalDialog(
      title = "Configuration Saved",
      "The configurations have been saved successfully.",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  # Observador para limpar configuração
  
  observeEvent(input$clear_config, {
    clear_saved_params()
    updateTextInput(session, "file_name", value = "")
    updateSelectInput(session, "column_name", selected = "")
    updateRadioButtons(session, "ri_type", selected = "Double-sided")
    updateNumericInput(session, "decimal_places", value = 2)
    updateTextInput(session, "responsible_person", value = "")
    updateTextAreaInput(session, "measurement_procedure", value = "")
    updateRadioButtons(session, "measurand_name", selected = "yes")
    updateTextInput(session, "name_of_measurand", value = "")
    updateTextInput(session, "unit", value = "")
    updateTextInput(session, "specimen", value = "")
    updateTextInput(session, "age_range", value = "")
    updateTextInput(session, "sex", value = "")
    updateTextAreaInput(session, "exclusion_criteria", value = "")
    updateTextInput(session, "data_source", value = "")
    updateTextInput(session, "upper_ref_limit", value = "")
    updateTextInput(session, "lower_ref_limit", value = "")
    updateTextAreaInput(session, "comp_ref_source", value = "")
    updateNumericInput(session, "max_sample_size", value = 10000)
    
    showModal(modalDialog(
      title = "Configuração Limpa",
      "As configurações foram limpas com sucesso.",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  
  # Observador para gerar relatório
  
  observeEvent(input$generate_report, {
    if (is.null(input$file_name) || input$column_name == "") {
      showModal(modalDialog(
        title = "Erro",
        "Por favor, preencha os campos obrigatórios: Nome do Arquivo e Nome da Coluna.",
        easyClose = TRUE,
        footer = NULL
      ))
      return()
    }
    
    withProgress(message = 'Gerando Relatório...', value = 0, {
      tryCatch({
        incProgress(0.1, detail = "Preparando parâmetros...")
        save_params(input)
        
        # Define o caminho para salvar o relatório dentro de `5_Output_Report`
        
        output_file <- file.path(output_dir, "Report_LabRI_method.html")
        params <- list(
          File_Name = input$file_name$name,
          Column_Name = input$column_name,
          Double_sided = ifelse(input$ri_type == "Double-sided", "x", ""),
          Right_sided = ifelse(input$ri_type == "Right-sided", "x", ""),
          Number_of_decimal_places = as.character(input$decimal_places),
          Responsible_person = input$responsible_person,
          Measurement_procedure_and_analytical_method = input$measurement_procedure,
          measurand_name = input$measurand_name,
          Name_of_measurand = input$name_of_measurand,
          Unit_of_measurement = input$unit,
          Type_of_specimen = input$specimen,
          Age_range = input$age_range,
          Sex = input$sex,
          Exclusion_criteria = input$exclusion_criteria,
          Data_source = input$data_source,
          Upper__Reference__Limit__of__Comparative_Reference = input$upper_ref_limit,
          Lower__Reference__Limit__of__Comparative_Reference = input$lower_ref_limit,
          Source_of_comparative_reference_used = input$comp_ref_source,
          Maximum_sample_size = as.character(input$max_sample_size)
        )
        
        # Passos de renderização simulados
        
        incProgress(0.3, detail = "Inicializando renderização de RMarkdown...")
        
        # Renderizando o relatório RMarkdown
        for (i in 1:5) {  # Dividindo em 5 etapas fictícias para exibir progresso em 10% cada
          Sys.sleep(0.2)  # Simulando tempo de processamento
          incProgress(0.1, detail = paste(10 * (i + 2), "% Renderizado..."))
        }
        
        render("3_SCRIPT_LabRI_Method.Rmd", 
               output_file = output_file, params = params, envir = globalenv())
        
        incProgress(1, detail = "Relatório gerado com sucesso!")
        
        
        # Atualiza o conteúdo da aba "Relatório" com o HTML gerado
        
        output$report_content <- renderUI({
          tags$iframe(src = "report/Report_LabRI_method.html", 
                      width = "100%", 
                      height = "800px",
                      frameborder = "0")
        })
        
        # Muda automaticamente para a aba do relatório
        updateTabsetPanel(session, "tabs", selected = "relatorio")
        
        # Exibe uma mensagem para o usuário informando sobre o sucesso
        showModal(modalDialog(
          title = "Relatório Concluído",
          "O relatório foi gerado com sucesso e está disponível para visualização na aba 'Relatório'.",
          easyClose = TRUE,
          footer = tagList(
            modalButton("Fechar"),
            downloadButton("download_report", "Salvar Relatório")
          )
        ))
        
        # Função de download para salvar o arquivo
        output$download_report <- downloadHandler(
          filename = function() {
            "Report_LabRI_method.html"
          },
          content = function(file) {
            file.copy(output_file, file)
          }
        )
        
      }, error = function(e) {
        showModal(modalDialog(
          title = "Erro ao Gerar Relatório",
          paste("Ocorreu um erro ao gerar o relatório:", e$message),
          easyClose = TRUE,
          footer = NULL
        ))
      })
    })
  })
  
}

shinyApp(ui = ui, server = server)


