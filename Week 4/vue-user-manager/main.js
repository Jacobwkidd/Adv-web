const uda = new UserDataAccess();

const rootComponent = {
    template:   `<div>
                    <h1>User Manager</h1>
                    <p>Number of users: {{users.length}}</p>
                    <br>
                    <button @click="addUser">Add User</button>
                    <!--We'll add a few Vue components here later-->
                    <user-list :users="users" @user-selected="handleUserSelected" /> 
                    <user-form
                        v-if="selectedUserId"
                        :userId="selectedUserId"
                        :key="selectedUserId"
                        @user-form-submitted="handleUserFormSubmitted" 
                        @delete-user="handleDeleteUser" />
                </div>`, // v-bind:users="users"   ==   :users="users"         Props is = :users then we have users 
    data(){ // : will go through when the code needs to go into javascript :: v-on:click == @click
        return { // v-if is binding the userId to selectedUserId and if this is false then it will not send
            users: uda.getAllUsers(),  // users are referncing the users in v-bind 
            selectedUserId: null
        }
    },
    methods:{
        addUser(){
            // alert("TODO: Add new user");
            // Uncomment the line below to see how Vue is 'reactive':
            // this.users.push({id:4, firstName:"Foo", lastName:"Bar"});
            this.selectedUserId = -1;
        },
        handleUserSelected(user){
            this.selectedUserId = user.id
            console.log("TODO: Show details for user " + this.selectedUserId);
        },
        handleUserFormSubmitted(user){
            if(user.id > 0){
                uda.updateUser(user);
            }
            else{
                uda.insertUser(user);
            }
            this.users = uda.getAllUsers();
        },
        handleDeleteUser(id){
            uda.deleteUser(id);
            this.users = uda.getAllUsers(); // this will refresh the user-list
            this.selectedUserId = 0; // this will hide the user-form
        }
    }
};

const app = Vue.createApp(rootComponent);

// We'll define a few more Vue components here
// UserList component:
app.component("user-list", {
    // props: {
    //     users: {
    //         type: Array,
    //         required: true
    //     }
    // },
    props: ["users"], // easiest way to define a props
    template: `
		<div class="user-list">
            <h2>User List</h2>
			<ul>
				<li v-for="user in users" :key="user.id" @click="handleClick(user)">
					{{ user.firstName + " " + user.lastName }}
				</li>
			</ul>
		</div>`, // users in the v-for is a prop the is in prop:["users"]
    methods: { // v-for is a loop
        handleClick(user){
            console.log("LI clicked for this user:", user);
            this.$emit("user-selected", user);
        },
    }
});

// UserForm component
app.component("user-form", {
    // props: {
    // 	userId: {
    // 		type: Number
    // 	}
    // },
    props: ["userId"],
    data(){
    	return {
    		firstName:"",
    		lastName:"",
    		email:""
    	}
    }, // @submit.prevent="handleSubmit" is waiting until you hit the submit button and .prevent == event.defaultprevent()
    template: `
        <div class="user-form-container">
        	<h2>User Details</h2>
            <form @submit.prevent="handleSubmit">
				<div>
				    <label>First Name:</label>
				    <input v-model="firstName" />
                </div>
                <div>
				    <label>Last Name:</label>
				    <input v-model="lastName" />
                </div>
                <div>
				    <label>Email:</label>
				    <input v-model="email" />
                </div>
                <div>
				    <input type="submit" id="btnSubmit" name="submit button">
                    <input type="button" value="delete" v-if="userId > 0" @click="handleDeleteClick" />
				</div>
			</form>
		</div>`,
    mounted(){
    	// if the userId prop was passed in, then get the user for that ID
        if(this.userId > 0){ // UPDATE THE BOOLEAN EXPRESSION TO  LOOK LIKE THIS
            const user = uda.getUserById(this.userId);
            // initialize all the data members declared for this component
            this.firstName = user.firstName;
            this.lastName = user.lastName;
            this.email = user.email;
        }
    },
    methods:{
    	handleSubmit(){
    		console.log("TODO: validate the input!");
    		console.log(this.userId, this.firstName, this.lastName, this.email);

            const user = {
                id: this.userId,
                firstName: this.firstName,
                lastName: this.lastName,
                email: this.email
            }
            this.$emit('user-form-submitted', user);
    	},
        handleDeleteClick(){
            if(confirm(`Are you sure you want to delete ${this.firstName} ${this.lastName}?`)){
                this.$emit('delete-user', this.userId);
            }
        }
    }
});

app.mount('#app');