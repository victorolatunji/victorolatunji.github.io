// Name: Victor Olatunji
// File: main.js
// Date: Aug 8 2025
// Lab 5 Accessibility troubleshooting
// Course: Web Development Fundamentals (INFT1206)

const showHideBtn = document.querySelector('.show-hide');
const commentWrapper = document.querySelector('.comment-wrapper');

commentWrapper.style.display = 'none';
showHideBtn.setAttribute('tabindex', '0');

// functionality for showing/hiding the comments section

function toggleComments() {
  const isHidden = commentWrapper.style.display === 'none';
  commentWrapper.style.display = isHidden ? 'block' : 'none';
  showHideBtn.textContent = isHidden ? 'Hide comments' : 'Show comments';
  showHideBtn.setAttribute('aria-expanded', isHidden);
}

showHideBtn.addEventListener('click', toggleComments);
showHideBtn.addEventListener('keydown', function(e) {
  if (e.key === 'Enter' || e.key === ' ') {
    e.preventDefault();
    toggleComments();
  }
});

// functionality for adding a new comment via the comments form

const form = document.querySelector('.comment-form');
const nameField = document.querySelector('#name');
const commentField = document.querySelector('#comment');
const list = document.querySelector('.comment-container');

form.onsubmit = function(e) {
  e.preventDefault();
  submitComment();
};

function submitComment() {
  const listItem = document.createElement('li');
  const namePara = document.createElement('p');
  const commentPara = document.createElement('p');
  const nameValue = nameField.value.trim();
  const commentValue = commentField.value.trim();

  if (!nameValue || !commentValue) return;

  namePara.textContent = nameValue;
  commentPara.textContent = commentValue;

  list.appendChild(listItem);
  listItem.appendChild(namePara);
  listItem.appendChild(commentPara);

  nameField.value = '';
  commentField.value = '';
}



