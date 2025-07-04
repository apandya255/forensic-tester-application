num1 = readline("Enter first number: ")
num2 = readline("Enter second number: ")
numbers = c(strtoi(num1),strtoi(num2))
operation = readline("What operation would you like to do? ")
if (operation == "add" | operation == "Add") {
  print(sum(numbers))
}
if (operation == "subtract" | operation == "Subtract") {
  print()
}
if (operation == "divide" | operation == "Divide") {
  print(num1/num2)
}
if (operation == "multiply" | operation == "Multiply") {
  print(num1*num2)
}