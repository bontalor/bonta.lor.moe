function goBack() {
    // Get the current URL path
    const currentUrl = window.location.pathname;

    // Split the URL into its segments
    const pathSegments = currentUrl.split('/').filter(segment => segment !== '');

    // Remove the last segment (to go back one directory level)
    pathSegments.pop();

    // If the path is empty (i.e., we're at the root), stay there
    if (pathSegments.length === 0) {
        window.location.href = '/';
    } else {
        // Join the remaining segments to form the new URL path
        const newPath = '/' + pathSegments.join('/');

        // Check if the new path exists by attempting to load it
        fetch(newPath, { method: 'HEAD' })
            .then(response => {
                // If the path doesn't exist (404), go back to the root
                if (response.status === 404) {
                    window.location.href = '/';
                } else {
                    // Otherwise, navigate to the new path
                    window.location.href = newPath;
                }
            })
            .catch(() => {
                // If fetch fails, also go to the root
                window.location.href = '/';
            });
    }
}