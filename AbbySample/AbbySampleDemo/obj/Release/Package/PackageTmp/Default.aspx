<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AbbySampleDemo.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ABBY</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="libs/css/web-capture.css" rel="stylesheet"/>
    <script src="libs/js/web-capture.js"></script>
    <%--<script src="libs/js/wasm-worker.js"></script>
    <script src="libs/js/wasm_engine.js"></script>--%>
    <style type="text/css">
        @font-face
        {
            font-family: 'SourceSansPro';
            font-weight: 600;
            src: url('libs/css/SourceSansPro-Semibold.woff2') format('woff2'); /* Chrome 26+, Opera 23+, Firefox 39+ */
        }

        @font-face
        {
            font-family: 'SourceSansPro';
            font-weight: 900;
            src: url('css/SourceSansPro-Black.woff2') format('woff2'); /* Chrome 26+, Opera 23+, Firefox 39+ */
        }

        @font-face
        {
            font-family: 'SourceSansPro';
            src: url('libs/css/SourceSansPro-Regular.woff2') format('woff2'); /* Chrome 26+, Opera 23+, Firefox 39+ */
        }

        html,
        body
        {
            font-family: SourceSansPro, Arial, sans-serif;
            font-weight: 600;
            height: 100%;
            margin: 0;
            padding: 0 8px;
        }

        body
        {
            display: flex;
            justify-content: center;
        }

        .demo_app-container
        {
            display: flex;
            flex-direction: column;
            align-items: center;
            max-width: 400px;
        }

        .content-container
        {
            display: flex;
            flex-direction: column;
            align-items: center;
            height: calc(100% - 72px);
        }

        .capturedImage
        {
            margin-left: 8px;
            margin-bottom: 16px;
            float: left;
            width: calc(33% - 8px);
            cursor: pointer;
        }

        .capturedImage:nth-child(3n + 1)
        {
            clear: both;
        }

        button
        {
            width: 200px;
            height: 52px;
            border-radius: 8px;
            background-color: #4a8ee0;
            color: white;
            border: 0;
            font-size: 18px;
            font-family: SourceSansPro, sans-serif;
            font-weight: 600;
        }

        span.loading
        {
            display: inline-block;
            background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAltJREFUSA2tlUFLFVEUx988fZVG4VNLy0AqayWoC9FWQYGbcB/UpqI2fYCgb9AiCMLv4EJo2SZpFyqICGaKQaVvkakFZfUs7fX7DTPV5CT5nAO/d+6795zzv3funbm53A5WqVTa4BY8gnnYgptQAwWohfwOJXK1aYMktdJ/B65CAYyTAGKzcI0Q/wNfDoJgKx6M/Z8JYR/BAzSG4BBY9AU8hil4S5EpYsyzuOL7oraC64yX8elG4jV4DSV4ChfSI3/3EuOjKkILHAcntt0YuAgL8AoewIHtUek9xAagyAloh4OJSDqOwiS4kfcTg7v4Q24znILTEO5vfAJuU8cZz8HdXdT8O/Q9HW60xY84mEepBT8Im3CPTdrAV2XkeprWwAPQRO2CKzgPFZgj4Bl+T0aNdQo4WUUaFDgXdYziszJFfExFBY6Bz+05ZGVfKKRAnQJFcEkrkJVZT4F6f9wYV+A+ZGW+6WFtV7AMKjZCVrafQgpsKlCyAWcgK2ugkAIbCoyBj6gPsrI2CnlM12KBb/zxO9KzV4XoxfXguIJ3eV6MVRpPwFVcIcDPb1VGrrPuAn2J2l9dgTYMvhwu7QZUa/0kNoEn0nskFwqg5EfqIbjZ/czEa9LL5L+MWK9OPzkd4OwnnL3JiRuNIG+zy+C7sQgjBM7i/2nktDPoATkMPuYxcsLZ004K2EFCN+46uEkmLME0vIGP4PK9UFrhJHgkjSvDKMWN+2WJFcS9iJh0CXrB1fjoLKKX75G3z/YMjFP8Mz5hqQJxRCTUyf+z4NGrAwU/gKfvpVD4Ez7VfgJCZBqGvW8R+gAAAABJRU5ErkJggg==');
            width: 24px;
            height: 24px;
            animation-name: spin;
            animation-duration: 1.2s;
            animation-iteration-count: infinite;
            animation-timing-function: linear;
        }

        @keyframes spin
        {
            100%
            {
                transform: rotate(360deg);
            }
        }

        button:disabled
        {
            opacity: 0.3;
        }

        #image_uploads
        {
            position: absolute;
            height: 100%;
            width: 100%;
            opacity: 0;
            display: none;
        }

        #error-text
        {
            color: red;
        }
    </style>
</head>
<body>
<div class="demo_app-container" style="height: 100%;">
    <img src="images/logo-mwc.svg" width="226" height="24" style="margin-bottom: 16px; margin-top: 32px;"/>
    <div id="content-container-content" class="content-container">
        <div style="font-size: 32px; line-height: 1.19; width: 320px; text-align: center; margin-bottom: 16px;">
            Use your browser to scan documents
        </div>
        <div id="content" style="overflow-y: auto; width: 100%; flex-grow: 1;"></div>
        <div id="error-text"></div>
        <div style="align-items: center; display: flex; margin: 16px 0; position: relative">
            <button id="demo_app-start_button1" disabled onclick="Start()">Try now</button>
            <input
                type="file"
                id="image_uploads"
                name="image_uploads"
                accept="image/x-png,image/gif,image/jpeg"
                multiple/>
        </div>
    </div>
</div>

<script>
    // results from webCapture module
    let resultCache = [];
    let stopImageEvents = false;
    let localizedStrings = {};

    // draw image previews and correct button text
    const updateView = () =>
    {
        document.getElementById('demo_app-start_button1').innerHTML =
            resultCache.length > 0 ? 'Capture more pages' : 'Try now';
        if(resultCache.length === 0)
        {
            const maxHeight = document.getElementById('content').offsetHeight;

            // placeholder image if no image captured
            document.getElementById('content').innerHTML =
                '<div style="height: 100%;display: flex;align-items: center"><img src="images/pages.svg" width="auto" height="auto"  style="display:block;margin:0 auto;max-height:' +
                maxHeight +
                'px"/></div>';
        }
        else
        {
            // draw preview captured images with click handler = open WebCapture app
            document.getElementById('content').innerHTML = resultCache
                .map((img, i) =>
                {
                    return '<img class="capturedImage" src="' + img.capturedImage + '" onClick="Start(' + i + ')"/>';
                })
                .join('');
        }
    };

    document.addEventListener('DOMContentLoaded',
        () =>
        {
            // load localized strings from external file
            fetch('js/localizedStrings.json')
                .then((res) => res.json())
                .then((res) => (localizedStrings = res));

            // create initial view
            updateView();
            // enable button after web-capture.js script loaded
            document.getElementById('demo_app-start_button1').disabled = false;

            // optional init phase, preload wasm scripts
            // indicate loading on button
            document.getElementById('demo_app-start_button1').innerHTML = '<span class="loading"/>';

            const options = {
                licenseFilePath: 'libs/js/MWC.ABBYY.License', // relative to wasm files (default folder /libs/js) or absolute path
                wasmFilesPath: 'libs/js' // relative to index.html or absolute path
            };

            // start loading wasm
            window.ABBYY.WebCapture.init(options)
                .then(updateView) // after loading restore button to original view
                .catch((e) =>
                {
                    if(e === 'Error loading wasm scripts')
                    {
                        const errorStr = "The specified path can't be found: " + options.wasmFilesPath;
                        const errorHtmlStr =
                            'Initialization failed(' + e + '). <br/> ' + 'The module cannot be started. <br/>' + errorStr;

                        console.error(errorStr);
                        displayError(errorHtmlStr, e);

                        document.getElementById('demo_app-start_button1').disabled = true;
                        document.getElementById('demo_app-start_button1').innerHTML = 'Attach files';
                    }
                    else
                    {
                        const errorHtmlStr =
                            'Initialization failed(' +
                                e +
                                '). <br/> ' +
                                'The module cannot be started. <br/>Fallback from\n' +
                                '      webcapture to native html functionality will be used.';

                        displayError(errorHtmlStr, e);
                        revertToClassicBrowseButton();
                    }
                });
        });

    const displayError = (errorHtmlStr, e) =>
    {
        const errorStr = 'Error during initialization: ' + e.toString();
        console.error(errorStr);

        document.getElementById('error-text').innerHTML = errorHtmlStr;
    };

    // sample
    const Start = () =>
    {
        if(stopImageEvents)
        {
            return;
        }

        const options = {
            startPage: resultCache.length || 0,
            images: resultCache,
            localizedStrings,
            minCameraResolution: 400,
        };

        window.ABBYY.WebCapture.capture(options)
            .then((imgs) =>
            {
                // store results in cache
                resultCache = imgs;
                // redraw preview
                updateView();
            })
            .catch((e) =>
            {
                console.error('Error during capture: ' + e.toString());
            });
    };

    const revertToClassicBrowseButton = () =>
    {
        const button = document.getElementById('demo_app-start_button1');

        button.disabled = false;
        button.innerHTML = 'Attach files';
        button.removeAttribute('onClick');
        // show input type file with opacity 0
        document.getElementById('image_uploads').style.display = 'block';

        stopImageEvents = true;

        document.getElementById('image_uploads').addEventListener('change',
            (ev) =>
            {
                Promise.all(
                    Array.prototype.map.call(ev.target.files,
                        (file) =>
                        {
                            return new Promise((resolve) =>
                            {
                                const reader = new FileReader();

                                reader.onload = () =>
                                {
                                    resolve(reader.result);
                                };

                                reader.readAsDataURL(file);
                            });
                        })
                ).then((result) =>
                {
                    resultCache = result.map((img) => ({
                        capturedImage: img,
                    }));
                    updateView();
                });
            });
    };
</script>

</body>
</html>