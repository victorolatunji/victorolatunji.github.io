// Author: Victor Olatunji
// Date: 14th of July 2025
// Purpose: Practice Examples on my own
// Course: Web Development Fundamentals -->

/* Write a function buildArray that takes two Numbers, and returns
an Array filled with all numbers between the given
number: buildArray(5, 10) should return [5, 6, 7, 8, 9, 10]--> */

console.log('Practice 1 Arrays')

function buildArray(start, end) {
  // Create an empty array to store the numbers
  let result = [];

  // Loop from the starting number up to the ending number (inclusive)
  for (let i = start; i <= end; i++) {
    // Add the current number to the array
    result.push(i);
  }

  // Return the completed array
  return result;
}

document.querySelector('#genNum').addEventListener('click', buildArray)

// Test the function by calling it with 5 and 10
// console.log(buildArray(5, 10)); // Output: [5, 6, 7, 8, 9, 10]