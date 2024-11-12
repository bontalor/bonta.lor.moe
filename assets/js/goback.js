function goBack() {
    // Get the current URL path
    const currentUrl = window.location.pathname;

    // Split the URL into segments, removing any empty strings caused by leading/trailing slashes
    const pathSegments = currentUrl.split('/').filter(segment => segment !== '');

    // If we're already at the root (empty path), do nothing
    if (pathSegments.length === 0) {
        return;
    }

    // Remove the last segment to "go up" one level
    pathSegments.pop();

    // Join the remaining segments to form the new URL path
    const newPath = '/' + pathSegments.join('/');

    // If the new path is empty, go to the root
    if (newPath === '/') {
        window.location.href = '/';
    } else {
        // Otherwise, try navigating to the new path
        window.location.href = newPath;
    }
}