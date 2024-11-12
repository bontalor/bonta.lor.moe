function goBack() {
    // Get the current URL
    const currentUrl = window.location.pathname;

    // Split the URL by slashes to work with individual path segments
    const pathSegments = currentUrl.split('/').filter(segment => segment !== '');

    // Remove the last segment to "go up" one level
    pathSegments.pop();

    // Join the remaining segments back into a path
    const newPath = '/' + pathSegments.join('/');

    // Redirect the user to the new path
    window.location.href = newPath || '/';  // If no segments are left, redirect to '/'
}
