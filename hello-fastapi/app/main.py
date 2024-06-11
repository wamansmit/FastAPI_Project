from fastapi import FastAPI
from fastapi.responses import HTMLResponse

app = FastAPI()

@app.get("/", response_class=HTMLResponse)
async def read_root():
    html_content = """
    <html>
        <head>
            <title>Personal Information</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                    background-color: #f0f0f0;
                }
                .window {
                    width: 400px;
                    border: 1px solid #ccc;
                    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                    background-color: #fff;
                }
                .title-bar {
                    background-color: #4CAF50;
                    color: white;
                    padding: 10px;
                    text-align: center;
                    font-weight: bold;
                    border-bottom: 1px solid #ccc;
                }
                .content {
                    padding: 20px;
                }
                .content p {
                    margin: 10px 0;
                }
                .hello-world {
                    text-align: center;
                    font-size: 1.5em;
                    margin-bottom: 20px;
                    color: #4CAF50;
                }
            </style>
        </head>
        <body>
            <div class="window">
                <div class="title-bar">Personal Information</div>
                <div class="content">
                    <div class="hello-world">Hello, World!</div>
                    <p><strong>Name:</strong> Smit Waman</p>
                    <p><strong>Profile:</strong> DevOps Intern Engineer</p>
                    <p><strong>Education:</strong> B.E. ETC (Pune University)</p>
                    <p><strong>Mobile Number:</strong> 9096214687</p>
                    <p><strong>Email ID:</strong> smitwaman007@gmail.com</p>
                    <p><strong>GitHub ID:</strong> smitwaman@git.com</p>
                    <p><em>This is a test application assignment for submission at Wobot Intelligence Technology using FastAPI.</em></p>
                </div>
            </div>
        </body>
    </html>
    """
    return HTMLResponse(content=html_content)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=9009)
