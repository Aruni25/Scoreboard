<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Excel File - Teachers</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0f7fa, #ffffff);
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: #0d47a1;
            margin-bottom: 30px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background-color: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .guidelines {
            background-color: #e3f2fd;
            border-left: 6px solid #2196f3;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 8px;
        }

        .guidelines h3 {
            color: #1565c0;
            margin-top: 0;
        }

        .guidelines ul {
            padding-left: 20px;
            line-height: 1.7;
        }

        .guidelines li {
            margin-bottom: 5px;
        }

        .upload-form label {
            font-weight: 600;
            color: #0d47a1;
        }

        .upload-form input[type="file"] {
            margin: 15px 0 25px;
            width: 100%;
            padding: 10px;
            border: 2px solid #90caf9;
            border-radius: 6px;
            background-color: #f1f8ff;
            font-size: 14px;
        }

        .upload-form input[type="submit"] {
            background-color: #1976d2;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .upload-form input[type="submit"]:hover {
            background-color: #0d47a1;
        }

       .image-guide {
    text-align: center;
    margin-top: 10px;
    overflow: hidden;
}

.image-guide img {
    width: 100%;
    max-width: 750px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    transition: transform 0.3s ease-in-out;
    cursor: zoom-in;
}

.image-guide img:hover {
    transform: scale(1.5);
    cursor: zoom-out;
    z-index: 999;
}
.magnifier-container {
    position: relative;
    display: inline-block;
}

#zoom-result {
    position: absolute;
    border: 3px solid #64b5f6;
    width: 200px;
    height: 200px;
    overflow: hidden;
    border-radius: 50%;
    display: none;
    z-index: 1000;
    pointer-events: none;
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
}

#zoomedImage {
    position: absolute;
    transform-origin: top left;
    transition: none;
}




        .footer-note {
            text-align: center;
            font-size: 13px;
            color: #607d8b;
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <h2>📤 Teacher Excel Upload Portal</h2>

    <div class="container">
        <div class="guidelines">
            <h3>📘 Upload Guidelines (For Teachers Only)</h3>
            <ul>
                <li>Ensure the file format is <strong>.xlsx</strong>.</li>
                <li>Do not include formulas or merged cells.</li>
                <li>Maximum size: <strong>5MB</strong>.</li>
                <li><strong>Please refer to the image below as an example for the required column order.</strong>></li>
                <li>Make sure the data is accurate and complete before uploading.</li>
            </ul>
        </div>

        <div class="image-guide">
    <div class="magnifier-container" id="magnifierContainer">
        <img id="mainImage" src="column_guide.PNG" alt="Excel Column Order" width="750">
        <div id="zoom-result">
            <img id="zoomedImage" src="column_guide.PNG" />
        </div>
    </div>
</div>



 <center>
        <form action="UploadExcelServlet" method="post" enctype="multipart/form-data">
            <label>Select Excel File:</label><br>
    <input type="file" name="excelFile" accept=".xlsx" required>
    <button type="submit">Upload</button>
</form>

    </div>

    <div class="footer-note">
        Powered by Cure on Call | For Internal Use Only
    </div>

<script>
    const mainImage = document.getElementById("mainImage");
    const zoomResult = document.getElementById("zoom-result");
    const zoomedImage = document.getElementById("zoomedImage");
    const zoomFactor = 2.5;

    mainImage.addEventListener("mouseenter", () => {
        zoomResult.style.display = "block";
    });

    mainImage.addEventListener("mouseleave", () => {
        zoomResult.style.display = "none";
    });

    mainImage.addEventListener("mousemove", function(e) {
        const rect = mainImage.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;

        const zoomX = x * zoomFactor;
        const zoomY = y * zoomFactor;

        // Position the zoom result lens near the cursor
        zoomResult.style.left = `${x - zoomResult.offsetWidth / 2}px`;
        zoomResult.style.top = `${y - zoomResult.offsetHeight / 2}px`;

        // Match zoomed image scale and move background exactly with cursor
        zoomedImage.style.width = `${mainImage.width * zoomFactor}px`;
        zoomedImage.style.height = `${mainImage.height * zoomFactor}px`;
        zoomedImage.style.left = `${-zoomX + zoomResult.offsetWidth / 2}px`;
        zoomedImage.style.top = `${-zoomY + zoomResult.offsetHeight / 2}px`;
    });
</script>


</body>
</html>
