output$CircomicsHowto <- renderPrint({
  cat("
      1 - Select Studies
      2 - Check availability
      3 - Load Genetic Profiles
      4 - Select Dimension
      5 - Compare colors with legend
      ")
})


### It is not necessary. le ListProfData is loaded when the output$StrListProfDataCircos <- renderPrint({}) is printed
# observe({
#   if(not_pressed(input$loadListProfDataCircosId)) return()
#   isolate({
#     shiny::withProgress(message = 'loading Profiles Data... ', value = 0.1, {
#       Sys.sleep(0.25)
#       getListProfData(panel='Circomics',input$GeneListID)
#     })
#
#   })
# })


observe({
  if (not_pressed(input$pullUserDataButtonId)) return()
  isolate({
    if('CNA' %in% input$userDataID ){
      #if(ncol(r_data[[input$UserData_CNA_id]]) -1 == length(r_data[[input$GeneListID]])){
      if(all(apply(r_data[[input$UserData_CNA_id]][-1],2, function(x)class(x)=='integer'))){
        r_data$ListProfData$CNA[['UserData']] <- r_data[[input$UserData_CNA_id]][-1] # [-1] rm first column
        # }
      }
    }
    if('mRNA' %in% input$userDataID ){
      if(all(apply(r_data[[input$UserData_mRNA_id]][-1],2, function(x)class(x)=='numeric'))){
        r_data$ListProfData$Expression[['UserData']] <- r_data[[input$UserData_mRNA_id]][-1]
      }
    }
    if('MetHM27' %in% input$userDataID ){
      if(all(apply(r_data[[input$UserData_MetHM27_id]][-1],2, function(x)class(x)=='numeric'))){
        r_data$ListProfData$Met_HM27[['UserData']] <- r_data[[input$UserData_MetHM27_id]][-1]
        r_data$ListMetData$HM27[['UserData']] <- r_data[[input$UserData_MetHM27_id]][-1]
      }
    }
    if( 'MetHM450' %in% input$userDataID2){
      if(all(apply(r_data[[input$UserData_MetHM450_id]][-1],2, function(x)class(x)=='numeric'))){
        r_data$ListProfData$Met_HM450[['UserData']] <- r_data[[input$UserData_MetHM450_id]][-1]
        r_data$ListMetData$HM450[['UserData']] <- r_data[[input$UserData_MetHM450_id]][-1]
      }
    }
    if( 'miRNA' %in% input$userDataID2){
      if(all(apply(r_data[[input$UserData_miRNA_id]][-1],2, function(x)class(x)=='numeric'))){
        r_data$ListProfData$miRNA[['UserData']] <- r_data[[input$UserData_miRNA_id]][-1]
      }
    }
    if( 'RPPA' %in% input$userDataID2){
      if(all(apply(r_data[[input$UserData_RPPA_id]][-1],2, function(x)class(x)=='numeric'))){
        r_data$ListProfData$RPPA[['UserData']] <- r_data[[input$UserData_RPPA_id]][-1]
      }
    }
    if( 'Mutation' %in% input$userDataID){
      # gene_symbol mutation_type amino_acid_change
      ## works for a list of data frame
      #if(any(sapply(r_data[[input$UserData_FreqMut_id]], function(x) sapply(names(x), function(y) grepl(paste("gene_symbol","mutation_type", "amino_acid_change", sep = "|"), y))))){
      if(length(grep('TRUE',sapply(names(r_data[[input$UserData_FreqMut_id]]), function(y) grepl(paste("gene_symbol","mutation_type", "amino_acid_change", sep = "|"), y))))==3){
        r_data$ListMutData[['UserData']] <- r_data[[input$UserData_FreqMut_id]][-1]
      }
    }
  })
})

observe({
  if (not_pressed(input$pullUserDataButtonId)) #return()
  isolate({
    r_data$ListProfData$CNA[['UserData']] <- NULL
    r_data$ListProfData$Expression[['UserData']] <- NULL
    r_data$ListProfData$Met_HM27[['UserData']] <- NULL
    r_data$ListMetData$HM27[['UserData']] <- NULL
    r_data$ListProfData$Met_HM450[['UserData']] <- NULL
    r_data$ListMetData$HM450[['UserData']] <- NULL
    r_data$ListProfData$miRNA[['UserData']] <- NULL
    r_data$ListProfData$RPPA[['UserData']] <- NULL
    r_data$ListMutData[['UserData']] <- NULL
  })
})


# output$StrProfData <- renderPrint({
#
#                    r_data$ListProfData$CNA[['UserData']] <- r_data[[input$UserData_CNA_id]]
#                    #cat("PROFILES DATA:\n",str(r_data$ListProfData$CNA),sep = " " )
#
# })
#
# output$CNATable <- DT::renderDataTable({
#   #r_data$ListProfData$CNA[['UserData']] <- r_data[[input$UserData_CNA_id]]
#
#   dat <- r_data[[input$UserData_CNA_id]]
#
#   displayTable(dat)
#
# })


## get Wheel for Profiles Data
output$getCoffeeWheel_All <- renderCoffeewheel({
  shiny::withProgress(message = 'Creating Wheel. Waiting...', value = 0.1, {
    Sys.sleep(0.25)

    #getListProfData(panel="Circomics")
    #Shiny.unbindAll()
    CoffeewheelTreeProfData <- reStrDimension(r_data$ListProfData)
    title<- paste("Profiles Data: CNA, Met,Exp, RPPA, miRNA")
    coffeewheel(CoffeewheelTreeProfData, width=600, height=600, partitionAttribute="value", main=title)
  })

})

## get Wheel for Methylation
output$getCoffeeWheel_Met <- renderCoffeewheel({
  shiny::withProgress(message = 'Creating Wheel. Waiting...', value = 0.1, {
    Sys.sleep(0.25)

    #getListProfData()
    CoffeewheelTreeMetData <- reStrDimension(r_data$ListMetData)
    title<- paste("Methylations: HM450 and HM27")
    coffeewheel(CoffeewheelTreeMetData, width=600, height=600, main=title)
  })

})

## get Wheel for CNA
output$getCoffeeWheel_CNA <- renderCoffeewheel({
  shiny::withProgress(message = 'Creating Wheel. Waiting...', value = 0.1, {
    Sys.sleep(0.25)

    #getListProfData()
    CoffeewheelTreeCNAData <- reStrDisease(r_data$ListProfData$CNA)
    title<- paste("Copy Number Alteration [-2, +2]")
    coffeewheel(CoffeewheelTreeCNAData, width=600, height=600,main=title)
  })

})

## get Wheel for mRNA
output$getCoffeeWheel_mRNA <- renderCoffeewheel({
  shiny::withProgress(message = 'Creating Wheel. Waiting...', value = 0.1, {
    Sys.sleep(0.25)

    #getListProfData()
    CoffeewheelTreeMetData <- reStrDisease(r_data$ListProfData$Expression)
    title<- paste("mRNA expression")
    coffeewheel(CoffeewheelTreeMetData, width=600, height=600, main=title)
  })

})

## get Wheel for miRNA
output$getCoffeeWheel_miRNA <- renderCoffeewheel({
  shiny::withProgress(message = 'Creating Wheel. Waiting...', value = 0.1, {
    Sys.sleep(0.25)

    #getListProfData()
    CoffeewheelTreeMetData <- reStrDisease(r_data$ListProfData$miRNA)
    title<- paste("miRNA Expression")
    coffeewheel(CoffeewheelTreeMetData, width=600, height=600, main= title)
  })

})

## get Wheel for RPPA
output$getCoffeeWheel_RPPA <- renderCoffeewheel({
  shiny::withProgress(message = 'Creating Wheel. Waiting...', value = 0.1, {
    Sys.sleep(0.25)

    #getListProfData()
    CoffeewheelTreeMetData <- reStrDisease(r_data$ListProfData$RPPA)
    title<- paste("Reverse Phase Protein Arrays")
    coffeewheel(CoffeewheelTreeMetData, width=600, height=600,main=title)
  })

})

## get Wheel for Mutation
output$getCoffeeWheel_Mut <- renderCoffeewheel({
  shiny::withProgress(message = 'Creating Wheel. Waiting...', value = 0.1, {
    Sys.sleep(0.25)

    ## get Gene Mutation Frequency
    print("Start getting Frequency of Mutation ...")
    Freq_DfMutData <- getFreqMutData(list = r_data$ListMutData, geneListLabel = input$GeneListID)
    print("End getting Mutation Frequency...")
    listMut_df <- apply(Freq_DfMutData,2,function(x)as.data.frame(t(x)))
    TreeMutData <- reStrDisease(listMut_df)
    coffeewheel(TreeMutData, width=700, height=600
                #,main= paste0("Mutation Frequency: (Min = ", min(r_data$Freq_DfMutData) ,", Max = ", max(r_data$Freq_DfMutData)  ,")", sep="")
    )
  })

})


# output$Save_Metabologram_All <- downloadHandler(
#   filename = function() {
#     paste(getwd(),"Metabologram_All.pdf", sep="/")
#   },
#   content = function(file) {
#     #png(file)
#     saveWidget(
#     #file.copy(
#    # pdf(file=file, width=12, height=8)
#     #SaveMetabologram_All()
#     #dev.off()
#       #metabologramOutput('metabologram_All')
#       CoffeewheelTreeProfData <- reStrDimension(r_data$ListProfData),
#       title<- paste("Profiles Data: CNA, Met,Exp, RPPA, miRNA"),
#       #coffeewheel(CoffeewheelTreeProfData, width=600, height=600, partitionAttribute="value", main=title)
#       metabologram(CoffeewheelTreeProfData, width=600, height=600, main=title,
#                    showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"),
#                    legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
#       , file)
#       #dev.off()
#   }
# )

#### Save circular layouts

# SaveMetabologram_CNA <- reactive({
#   CoffeewheelTreeProfData <- reStrDimension(r_data$ListProfData$CNA)
#   title<- paste("Copy Number Alateration")
#   bioCancer::metabologram(CoffeewheelTreeProfData, width=800, height=800, main=title, showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"), legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
# 
# })
# 
# SaveMetabologram_Met <- reactive({
#   CoffeewheelTreeProfData <- reStrDimension(r_data$ListMetData)
#   title<- paste("DNA Methylation")
#   bioCancer::metabologram(CoffeewheelTreeProfData, width=800, height=800, main=title, showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"), legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
# 
# })


# SaveMetabologram_mRNA <- reactive({
#   CoffeewheelTreeProfData <- reStrDimension(r_data$ListProfData$Expression)
#   title<- paste("mRNA expression")
#   metabologram(CoffeewheelTreeProfData, width=800, height=800, main=title, showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"), legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
#
# })
#
#
# SaveMetabologram_RPPA <- reactive({
#   CoffeewheelTreeProfData <- reStrDimension(r_data$ListProfData$RPPA)
#   title<- paste("Reverse Phase Protein Arrays")
#   metabologram(CoffeewheelTreeProfData, width=800, height=800, main=title, showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"), legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
#
# })
#
# SaveMetabologram_RPPA <- reactive({
#   CoffeewheelTreeProfData <- reStrDimension(r_data$ListProfData$miRNA)
#   title<- paste("miRNA Expression")
#   metabologram(CoffeewheelTreeProfData, width=800, height=800, main=title, showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"), legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
#
# })
#
# SaveMetabologram_All <- reactive({
#   CoffeewheelTreeProfData <- reStrDimension(r_data$ListProfData)
#   title<- paste("Profiles Data: CNA, Met,Exp, RPPA, miRNA")
#   metabologram(CoffeewheelTreeProfData, width=800, height=800, main=title, showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"), legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
# 
# })

# SaveMetabologram_Mut <- reactive({
#   Freq_DfMutData <- getFreqMutData(list = r_data$ListMutData)
#   print("End getting Mutation Frequency...")
#   listMut_df <- apply(Freq_DfMutData,2,function(x)as.data.frame(t(x)))
#   TreeMutData <- reStrDisease(listMut_df)
#   #coffeewheel(TreeMutData, width=600, height=600, main="Mutation Frequency: (Min,Max)")
#   title<- paste("Mutation")
#   metabologram(TreeMutData, width=800, height=800, main=title, showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"), legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
#
# })

# output$dl_metabologram <- downloadHandler(
#   filename='plot.png',
#   content= getmetabologram()
# )

# output$metabologram_All <- renderMetabologram({
#
#   CoffeewheelTreeData <- reStrDimension(r_data$ListProfData)
#
#   ### get Legend for static coffewheel
#   #devtools::install_github("armish/metabologram")
#   #library("metabologram")
#   title<- paste("Wheel with selected Studies")
#   metabologram(CoffeewheelTreeData, width=600, height=600, main=title,
#                showLegend = TRUE, fontSize = 10, legendBreaks=c("NA","Min","Negative", "0", "Positive", "Max"),
#                legendColors=c("black","blue","cyan","white","yellow","red") , legendText="Legend")
# })




output$CircosAvailability <- DT::renderDataTable({
  
  shiny::withProgress(message = 'Loading Data...', value = 0.1, {
    Sys.sleep(0.25)
    dat <- checkDimensions(panel="Circomics", StudyID= input$StudiesIDCircos )
    ## remove rownames to column
    dat <- dat %>% tibble::rownames_to_column("Samples")
    
    # action = DT::dataTableAjax(session, dat, rownames = FALSE, toJSONfun = my_dataTablesJSON)
    action = DT::dataTableAjax(session, dat, rownames = FALSE)
    
    DT::datatable(dat, filter = list(position = "top", clear = FALSE, plain = TRUE),
                  rownames = FALSE, style = "bootstrap", escape = FALSE,
                  # class = "compact",
                  options = list(
                    ajax = list(url = action),
                    search = list(regex = TRUE),
                    columnDefs = list(list(className = 'dt-center', targets = "_all")),
                    autoWidth = TRUE,
                    processing = FALSE,
                    pageLength = 14,
                    lengthMenu = list(c(10, 25, 50, -1), c('10','25','50','All'))
                  )
    )%>%  DT::formatStyle(names(dat),
                          color = DT::styleEqual("No", 'red'))#, backgroundColor = 'white', fontWeight = 'bold'
    
    
    
    
  })
})


output$Sequenced_SampleSize <- DT::renderDataTable({
  
  shiny::withProgress(message = 'Computing Sample sizes...', value = 0.1, {
    Sys.sleep(0.25)
    
    dat <- getSequensed_SampleSize(StudyID = input$StudiesIDCircos)
    
    DT::datatable(dat,
                  caption= "Table 1: Sample Sizes by study",
                  autoHideNavigation = getOption("DT.autoHideNavigation")
    )
  })
})

output$FreqMutSummary <- DT::renderDataTable({
  # dat <- r_data$Freq_DfMutData %>% tibble::rownames_to_column("Genes")
  # rnames <- rownames(r_data$Freq_DfMutData)
  # rownames(r_data$Freq_DfMutData) <- NULL
  # FreqIn <- as.data.frame(r_data$Freq_DfMutData)
  # dat <- cbind("Genes"= rnames, r_data$Freq_DfMutData)
  DT::datatable(r_data$Freq_DfMutData,
                caption="Table 2: Percentage (%) of mutation by gene in each study",
                autoHideNavigation = getOption("DT.autoHideNavigation")
  )
})

output$mRNA_mean <- DT::renderDataTable({
  # if (inherits(try(lapply(r_data$ListProfData$Expression, function(x) lapply(x, function(y) colMeans(y))), silent=TRUE),"try-error")){
  #   r_data$ListProfData$ListMetData[['UserData']] <- NULL
  # }
  dat <- lapply(r_data$ListProfData$Expression, function(x) colMeans(x))
  dat <- as.data.frame(do.call(cbind,dat))
  dat <- round(dat, digits = 0)
  DT::datatable(dat,
                caption="Table 2: Means of mRNA expression",
                autoHideNavigation = getOption("DT.autoHideNavigation")
  )
})
output$CNA_Max <- DT::renderDataTable({
  # check if all dataframe have interger in each column
  #if(all(sapply((lapply(r_data$ListProfData$CNA,function(x) sapply(x, function(y) class(y)=='integer'))), function(f) all()))){
  #if (inherits(try(lapply(r_data$ListProfData$CNA,function(x) apply(x,2, function(y) as.data.frame(table(y[order(y)])))), silent=TRUE),"try-error")){
  # r_data$ListProfData$CNA[['UserData']] <- NULL
  #}
  ls <- lapply(r_data$ListProfData$CNA,function(x) apply(x,2, function(y) as.data.frame(table(y[order(y)]))))
  WhichMax <- lapply(ls, function(x) as.data.frame(do.call(cbind,lapply(x, function(y) y[,1][which(y[,2]== max(y[,2]))]))))
  genes_names <- lapply(WhichMax, function(x) names(x))[1]
  names(genes_names) <- 'Genes'
  WhichMax <- lapply(WhichMax, function(x) as.numeric(as.matrix(x)))
  WhichMax <-   as.data.frame(do.call(cbind, WhichMax))  # as.data.frame(WhichMax)
  dat <- cbind(Genes= genes_names , WhichMax )
  DT::datatable(dat,
                caption="Table 2: The most frequent CNA prolife",
                autoHideNavigation = getOption("DT.autoHideNavigation")
  )
  # }
})

output$Methylation_mean <- DT::renderDataTable({
  # if (inherits(try(lapply(r_data$ListMetData, function(x) lapply(x, function(y) colMeans(y))), silent=TRUE),"try-error")){
  # r_data$ListProfData$ListMetData[['UserData']] <- NULL
  # }
  #dat <- list(r_data$ListMetData,r_data$ListProfData$Met_HM450)
  dat <- lapply(r_data$ListMetData, function(x) lapply(x, function(y) colMeans(y)))
  dat <- as.data.frame(dat)
  dat <- round(dat, digits = 3)
  DT::datatable(dat,
                caption="Table 2: Correlation of silencing gene by Methylation: (0:1)",
                autoHideNavigation = getOption("DT.autoHideNavigation")
  )
})
