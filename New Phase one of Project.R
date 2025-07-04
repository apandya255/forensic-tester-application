library(readr)
dataFrame = read_csv("C:\\Users\\anand\\Downloads\\QC Data Actual (CSV).csv")
search.function = function () {
  print("Welcome student, and get ready to either check or search for data!")
  input = readline(prompt = "Enter Sample Number: ")
  indices = which(dataFrame$Sample == input)
  dataSubset = dataFrame[indices, ]
  print(dataSubset)
  again = readline("Would you like to find more data? ")
  if (again == "yes" | again == "Yes") {
    search.function()
  }else {
    print("Thank you for searching")
  }
}

search.function()

