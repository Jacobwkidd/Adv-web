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
                        :key="selectedUser"
                        v-if="selectedUser" 
                        :initialUser="selectedUser" 
                        @user-form-submitted="handleUserFormSubmitted"
                        @delete-user="handleDeleteUser" />
                </div>`, //change the key with the selectedUser then it will change the user when you click on the names
    data(){
        return {
            users: uda.getAllUsers(),
            selectedUser: null
        }
    },
    methods:{
        addUser(){
            //alert("TODO: Add new user");
            // Uncomment the line below to see how Vue is 'reactive': 
            //this.users.push({id:4, firstName:"Foo", lastName:"Bar"})
            this.selectedUser = {};
        },
        handleUserSelected(user){
            this.selectedUser = user  
        },
        handleUserFormSubmitted(user){
            if(user.id > 0){
                uda.updateUser(user);
            }else{
                uda.insertUser(user);
            }
            this.users = uda.getAllUsers();
        },
        handleDeleteUser(id){
            uda.deleteUser(id);
            this.users = uda.getAllUsers();
            this.selectedUserId = 0;
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
    props: ["users"],
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
            console.log("LI clicked for this user:", user); // user is a data memeber and it's a copy of the prop
            this.$emit("user-selected", user);
        },
    }
});


// UserForm component
app.component("user-form", {
    props:["initialUser"],
    data(){
        return {
            user: {...this.initialUser}
        }
    },
    template: `
        <div class="user-form-container">
            <h2>User Details</h2>
            <form @submit.prevent="handleSubmit">
                <div>
                    <label>First Name:</label>
                    <input v-model="user.firstName" />
                </div>
                <div>
                    <label>Last Name:</label>
                    <input v-model="user.lastName" />
                </div>
                <div>
                    <label>Email:</label>
                    <input v-model="user.email" />
                </div>
                <div>
                    <input type="submit" id="btnSubmit" name="submit button">
                    <input type="button" value="delete" v-if="user?.id > 0" @click="handleDeleteClick" />
                </div>
            </form>
        </div>`,
    methods:{
        handleSubmit(){
            this.$emit('user-form-submitted', this.user);
        },
        handleDeleteClick(){
            if(confirm(`Are you sure you want to delete ${this.user.firstName} ${this.user.lastName}?`)){
                this.$emit('delete-user', this.user);
            }
        }
    }
});


app.mount('#app');