## Fix Image Persistence Across Redeployments

### 1. Create ImageServlet for Serving Images
- [x] Create ImageServlet.java to serve images from persistent location

### 2. Update ProductServlet for Persistent Uploads
- [x] Change upload path to user home + "/ArtisanAlleyUploads"
- [x] Update imageUrl to "/image?file=filename"

### 3. Update editProduct.jsp
- [x] Modify image display logic to use new servlet URL

### 4. Update web.xml
- [x] Add servlet mapping for ImageServlet

### 5. Update all JSP files to use ImageServlet
- [x] productDetails.jsp
- [x] customerDashboard.jsp
- [x] sellerDashboard.jsp
- [x] cart.jsp
- [x] productList.jsp
- [ ] addProduct.jsp (no image display, skip)

### 6. Test Image Persistence
- [ ] Upload image, redeploy, verify image still displays
