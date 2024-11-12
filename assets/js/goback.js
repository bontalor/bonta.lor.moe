function goBack() {
    const currentUrl = window.location.pathname;
    const pathSegments = currentUrl.split('/').filter(segment => segment !== '');
    pathSegments.pop();
    const newPath = '/' + pathSegments.join('/');
    window.location.href = newPath || '/';
}