function goBack() {
    // Get the current URL path
    const currentUrl = window.location.pathname;

    // Split the URL into segments, removing any empty strings caused by leading/trailing slashes
    const pathSegments = currentUrl.split('/').filter(segment => segment !== '');

    // Remove the last segment to "go up" one level
    pathSegments.pop();

    // If there are no segments left, we're at the root, so stay there
    if (pathSegments.length === 0) {
        window.location.href = '/';
    } else {
        // Join the remaining segments to form the new URL path
        const newPath = '/' + pathSegments.join('/');

        // Navigate to the new path
        window.location.href = newPath;
    }
}