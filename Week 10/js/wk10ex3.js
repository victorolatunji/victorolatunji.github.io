// Author: Victor Olatunji
// Date: 14th of July 2025
// Purpose: Intro to Java Script
// Course: Web Development Fundamentals

console.log('Test 3');

function show(){
    //console.log('Hello')
    let num1 = document.querySelector('#num1').value;
    let num2 = document.querySelector('#num2').value;

    document.querySelector('#output').textContent = "The multiplication of " + num1 + " and " + num2 + " is " + (num1 * num2);
}

document.querySelector('#btnCal').addEventListener('click', show);
