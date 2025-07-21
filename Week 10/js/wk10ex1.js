// Author: Victor Olatunji
// Date: 14th of July 2025
// Purpose: Intro to Java Script
// Course: Web Development Fundamentals

console.log('Test 1');

function showGreeting(){
    //console.log('Hello')
    let fname = window.prompt('What is your first name?');
    window.alert("Hello " +fname);
}

//showGreeting();

document.querySelector('#btnGO').addEventListener('click', showGreeting);