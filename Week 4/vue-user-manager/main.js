const uda = new UserDataAccess();

const rootComponent = {
    template:   `<div>
                    <h1>User Manager</h1>
                    <p>Number of users: {{users.length}}</p>
                    <br>
                    <button @click="addUser">Add User</button>
                    <!--We'll add a few Vue components here later-->
                    <user-list :users="users" @user-selected="handleUserSelected" /> 
                </div>`,
    data(){ // : will go through when the code needs to go into javascript
        return {
            users: uda.getAllUsers(), 
            selectedUserId: null
        }
    },
    methods:{
        addUser(){
            alert("TODO: Add new user");
            // Uncomment the line below to see how Vue is 'reactive':
            // this.users.push({id:4, firstName:"Foo", lastName:"Bar"});
        },
        handleUserSelected(user){
            this.selectedUserId = user.id
            console.log("TODO: Show details for user " + this.selectedUserId);
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
		</div>`,
    methods: {
        handleClick(user){
            console.log("LI clicked for this user:", user);
            this.$emit("user-selected", user);
        },
    }
});

app.mount('#app');