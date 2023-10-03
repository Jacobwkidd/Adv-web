// To define a component in Vue you create an object that
// has certain properties, at a bare minimum it must have
// a 'template' property that defines the UI of the component
const rootComponent = {
	template: `<div id="app">
			    <HelloWorld msg="Hello World!"/>
			    <HelloWorld msg="Fooo"/>
			  </div>`
}
// Note that the template makes use of another component (HelloWorld), which defined below

const app = Vue.createApp(rootComponent);

//HelloWorld component
app.component("HelloWorld", {
	props: ["msg"],
	template:`<div>
				<h2>{{msg}}</h2>
			    <ul>
			      <li v-for="todo in todos" v-bind:key="todo">{{ todo }}</li>
			    </ul>
			    <form @submit.prevent="addTodo">
			      <input v-model="todoText" placeholder="What needs to be done?">
			      <button type="submit">Add Todo</button>
			    </form>
				<foo />
			  </div>`,
    data() {
	    return {
	      todos: [],
	      todoText: '',
	    };
	},
	methods:{
		addTodo: function () {
	      this.todos = [...this.todos, this.todoText]; //create a new array by passing through the old array
	      localStorage.setItem('todos', JSON.stringify(this.todos));
	    }
	},
	mounted: function () {
	    const existingTodos = localStorage.getItem('todos');
	    this.todos = JSON.parse(existingTodos) || [];
    }
});

app.component("foo", {
	template:"<h1>Foo</h1>"
});

app.mount('#app');