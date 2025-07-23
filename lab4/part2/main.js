// Name: Victor Olatunji
// File: lab4 
// Date: 23 July 2025
// Lab 4 Part 2 Image Gallery
// Course: Web Development Fundamentals (INFT1206)

const displayedImage = document.querySelector('.displayed-img');
const thumbBar = document.querySelector('.thumb-bar');

const btn = document.querySelector('button');
const overlay = document.querySelector('.overlay');

/* Declaring the array of image filenames */
const images = ['pic1.jpg', 'pic2.jpg', 'pic3.jpg', 'pic4.jpg', 'pic5.jpg'];

/* Declaring the alternative text for each image file */
const alts = {
            'pic1.jpg': 'Closeup of Human eye', 
            'pic2.jpg': 'Wavy Rock ', 
            'pic3.jpg': 'purple & white flowers',
            'pic4.jpg': 'Egyptian Drawing',
            'pic5.jpg': 'Butterfly'
            }

/* Looping through images */


/* Wiring up the Darken/Lighten button */
