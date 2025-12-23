document.querySelectorAll('.post-link').forEach((link) => {
    link.addEventListener('click', () => {
        // Copy the link to the clipboard
        const id = link.parentElement.id;
        const url = window.location.href.split('#')[0] + '#' + id;
        navigator.clipboard.writeText(url);

        // Replace the link icon with a check icon
        link.firstElementChild.classList.replace('bi-link-45deg', 'bi-check-lg');
    });
});
