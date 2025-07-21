// Author: Victor Olatunji
// Date: 14th of July 2025
// Purpose: Intro to Java Script
// Course: Web Development Fundamentals

console.log('Test 2');

function show(){
    let fname = document.querySelector('#fname').value;
    document.querySelector('#output').textContent = "Hello " +fname ;

}

document.querySelector('#btnGO').addEventListener('click', show)