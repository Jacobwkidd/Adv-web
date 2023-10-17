const baseURL = "http://localhost:3000/";

export function getAllPosts(){
	return axios.get(baseURL + "pages/")
		.then(resp => resp.data)
		.catch(errorHandler);
}

getPostById(id)
	.then(resp => console.log("RESPONSE:", resp))
	.catch(error => alert("Unable to get post with id of " + id));

