const http = require('http');
const fs = require('fs/promises');


const bootstrap = async () => {
	const callServer = (resquest, response) => {
		response.writeHead(200,{"Content-Type":"application/json"})
		response.end("Hello world! ");
	}
	
	let api = http.createServer(callServer);
		
	await fs.writeFile("./nd.pid",`${process.pid}`)
		
	let proc_api = api.listen(5000,()=> {
		console.log("Server");
	});	
}

bootstrap();
