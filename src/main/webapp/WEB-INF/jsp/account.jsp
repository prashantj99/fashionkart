<%@ page import="com.fashionkart.entities.User" %>
<%@ page import="com.fashionkart.utils.FirebaseStorageUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%
    User loggedInUser = (User) request.getSession().getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("/auth/user/login");
        return;
    }
%>
<%@include file="navbar.jsp" %>
<div class="my-4 max-w-screen-md border px-4 shadow-xl sm:mx-4 sm:rounded-xl sm:px-4 sm:py-4 md:mx-auto">
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } else if (request.getAttribute("message") != null) { %>
    <div class="mb-4 bg-green-100 text-green-700 p-4 rounded-lg">
        <%= request.getAttribute("message") %>
    </div>
    <%}%>
    <%--    user basic details update--%>
    <form action="/controller/account-details" method="post">
        <div class="flex flex-col  py-4 sm:flex-row sm:items-start gap-2">
            <div class="shrink-0 mr-auto sm:py-3">
                <p class="font-medium">Account Details</p>
                <p class="text-sm text-gray-600">Edit your account details</p>
            </div>
            <button type="reset"
                    class="rounded-lg border-2 border-red-500 text-red-500 px-4 py-2 font-medium focus:outline-none focus:ring hover:bg-red-100 hover:text-red-600">
                Cancel
            </button>
            <button type="submit"
                    class="rounded-lg border-2 border-blue-600 text-blue-600 px-4 py-2 font-medium bg-white focus:outline-none focus:ring hover:bg-blue-600 hover:text-white">
                Save
            </button>
        </div>
        <div class="flex flex-col gap-4 py-4 sm:flex-row">
            <p class="shrink-0 w-32 font-medium">Name</p>
            <input name="firstName" placeholder="First Name" value="<%=loggedInUser.getFirstName()%>"
                   class="mb-2 w-full rounded-md border bg-white px-2 py-2 outline-none ring-blue-600 sm:mr-4 sm:mb-0 focus:ring-1"/>
            <input name="lastName" placeholder="Last Name" value="<%=loggedInUser.getLastName()%>"
                   class="w-full rounded-md border bg-white px-2 py-2 outline-none ring-blue-600 focus:ring-1"/>
        </div>
        <div class="flex flex-col gap-4 py-4 sm:flex-row">
            <p class="shrink-0 w-32 font-medium">Email</p>
            <input placeholder="your.email@domain.com" value="<%=loggedInUser.getEmail()%>"
                   class="disabled w-full rounded-md border bg-white px-2 py-2 outline-none ring-blue-600 focus:ring-1"
                   disabled/>
        </div>
        <div class="flex flex-col gap-4  py-4 sm:flex-row">
            <p class="shrink-0 w-32 font-medium">Phone Number</p>
            <input placeholder="7814614161" value="<%=loggedInUser.getPhoneNumber()%>" name="phoneNumber"
                   class="w-full rounded-md border bg-white px-2 py-2 outline-none ring-blue-600 focus:ring-1"/>
        </div>
    </form>

    <%--    profile image updates--%>
    <form action="/controller/update-avatar" method="POST" enctype="multipart/form-data"
          class="flex gap-4 py-4 lg:flex-row">
        <div class="shrink-0 w-32 sm:py-4">
            <p class="mb-auto font-medium">Avatar</p>
            <p class="text-sm text-gray-600">Change your avatar</p>
        </div>
        <div class="flex h-56 w-full flex-col items-center justify-center gap-4 rounded-xl border border-dashed border-gray-300 p-5 text-center">
            <!-- Image Preview Element -->
            <img id="profileImagePreview"
                 src="<%=loggedInUser.getImage().startsWith("default") ? "https://img.icons8.com/ios-filled/50/user.png": FirebaseStorageUtil.generateSignedUrl(loggedInUser.getImage())%>"
                 class="h-16 w-16 rounded-full" alt="profileImg"/>

            <p class="text-sm text-gray-600">Drop your desired image file here to start the upload</p>

            <!-- File Input for Uploading Image -->
            <input type="file" id="imageUploadInput" accept="image/*" name="profileImage"
                   class="max-w-full rounded-lg px-2 font-medium text-blue-600 outline-none ring-blue-600 focus:ring-1"/>
            <div class="flex w-full justify-between">
                <button type="submit"
                        class="hidden w-full rounded-lg border-2 border-transparent bg-gray-600 px-4 py-2 font-medium text-white sm:inline focus:outline-none focus:ring hover:bg-gray-700">
                    update
                </button>
            </div>

        </div>
    </form>
    <%-- reset password--%>
    <form action="/controller/request-password-reset" method="post" class="flex justify-start py-4">
        <button type="submit" class="rounded-lg border-2 border-transparent bg-red-600 px-4 py-2 font-medium text-white focus:outline-none focus:ring hover:bg-red-700">
            Update Password
        </button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- jQuery Script for Image Preview -->
<script>
    $(document).ready(function () {
        $('#imageUploadInput').on('change', function (event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();

                reader.onload = function (e) {
                    $('#profileImagePreview').attr('src', e.target.result);
                }

                reader.readAsDataURL(file);
            }
        });
    });
</script>
</body>
</html>
