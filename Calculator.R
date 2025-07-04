num1 = readline("Enter first number: ")
num2 = readline("Enter second number: ")
num1 = strtoi(num1)
num2 = strtoi(num2)
operation = readline("What operation would you like to do? ")
if (operation == "add" | operation == "Add") {
  print(sum(num1+num2))
}
if (operation == "subtract" | operation == "Subtract") {
  print(sum(num1-num2))
}
if (operation == "divide" | operation == "Divide") {
  print(num1/num2)
}
if (operation == "multiply" | operation == "Multiply") {
  print(num1+num2)
}