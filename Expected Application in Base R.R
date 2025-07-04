library(readxl)
dataFrame = data.frame(read_excel("C:\\Users\\Anand\\Downloads\\QC Data Actual.xlsx",))



search.function = function () {
  samplenuminput = readline(prompt = "Enter Sample Number: ")
  indices = which(dataFrame["Sample"] == samplenuminput)
  dataSubset = dataFrame[indices, ]
  print(dataSubset)
  again = readline("Would you like to find more data? ")
  if (again == "yes" | again == "Yes") {
    search.function()
  }else {
    print("Thank you for searching")
  }
}

string.to.numeric = function(x){
  x = strsplit(x, " ")
  x = as.character(as.list((x)))
}

User.input.values = function () {
  usersample1 = c(readline(prompt = "Please Enter your data starting with sample #: "))
  usersample2 = c(readline(prompt = "Please Enter data for D8S1179: "))
  usersample3 = c(readline(prompt = "Please Enter data for D21S11: "))
  usersample4 = c(readline(prompt = "Please Enter data for D7S820: "))
  usersample5 = c(readline(prompt = "Please Enter data for CSF1PO: "))
  usersample6 = c(readline(prompt = "Please Enter data for D3S1358: "))
  usersample7 = c(readline(prompt = "Please Enter data for TH01: "))
  usersample8 = c(readline(prompt = "Please Enter data for D13S317: "))
  usersample9 = c(readline(prompt = "Please Enter data for D16S539: "))
  usersample10 = c(readline(prompt = "Please Enter data for D2S1338: "))
  usersample11 = c(readline(prompt = "Please Enter data for D19S433: "))
  usersample12 = c(readline(prompt = "Please Enter data for VWA: "))
  usersample13 = c(readline(prompt = "Please Enter data for TPOX: "))
  usersample14 = c(readline(prompt = "Please Enter data for D18S51: "))
  usersample15 = c(readline(prompt = "Please Enter data for AMEL: "))
  usersample16 = c(readline(prompt = "Please Enter data for D5S818: "))
  usersample17 = c(readline(prompt = "Please Enter data for FGA: "))
  usercheckindices = which(dataFrame["Sample"] == usersample1)
  dataSubsetcheck = dataFrame[usercheckindices, ]
  dataframeusercheck = data.frame(usersample1, usersample2, usersample3,usersample4, usersample5, usersample6, usersample7, usersample8, usersample9, usersample10, usersample11, usersample12, usersample13, usersample14, usersample15, usersample16, usersample17)
  names(dataframeusercheck) = c("Sample", "D8S1179", "D21S11", "D7S820", "CSF1PO", "D3S1358", "TH01", "D13S317", "D16S539 ", "D2S1338", "D19S433", "vWA", "TPOX", "D18S51", "AMEL", "D5S818", "FGA")
  if (all(dataframeusercheck == dataSubsetcheck)) {
    print("Congratulations!!! all of your values are correct")
  }
  else {
    print("Your data was incorrect")
    print("These were your inputted values")
    print(dataframeusercheck)
    print("These were the correct values")
    print(dataSubsetcheck)
  }
    
}
startup.function = function() {
  print("Welcome to this app where you will either check or find the answer key for data")
  startupinput = readline("what would you like to do? search, check, or exit: ")
  if (startupinput == "search" | startupinput == "Search") {
    search.function()
}
  if (startupinput == "check" | startupinput == "Check") {
    User.input.values()}
  if (startupinput == "exit" | startupinput == "Exit") {
    print("Thank you for using this app")}
}

  
startup.function()
