function div(a, b) {
  return `${a} / ${b} = ${a / b}`;
}

function protectFromZeroDivision(fn) {
  return function(a, b) {
    if (b === 0) {
      return "деление на ноль!";
    }
    return fn(a, b);
  }
}


const logStorage = []; // логи

function logFunctionCalls(fn) {
  return function(...args) {
    const result = fn(...args);
    const logEntry = {
      params: args,
      result: result,
      date: new Date().toString()
    };
    logStorage.push(logEntry);
    return result;
  }
}


const protectedDiv = protectFromZeroDivision(div);
const loggedProtectedDiv = logFunctionCalls(protectedDiv);

// Тестирование
console.log("Защита от деления на ноль");
console.log(protectedDiv(10, 2));
console.log(protectedDiv(10, 0));


console.log(loggedProtectedDiv(20, 0));
console.log(loggedProtectedDiv(15, 3));


console.log(logStorage);