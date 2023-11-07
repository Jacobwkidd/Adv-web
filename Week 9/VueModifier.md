# Vue Modifiers


Modifiers are added to the vue components to modify their functionality. Modifiers are most used to listen keyboard, mouse movement or click. Fun fact, we can use them together with each other.


The first modifier we will look would be .prevent


How to use


```js
<button @click.prevent="submit">Submit</button>
```
When you are writing a button, the .prevent modifier is to prevent the default action of an event. An example would be on a form element: the .prevent modifier will prevent the page from reloading, which is the default action of the form.

------------------------
This would mouseover
```js
<button v-on:mouseover = "submit">Submit</button>

```


This can help you collect data from a user. When a user goes over a button or anything other surface you plan on using this on.

-------------------------------
This is input


```js
<input v-on:input="inpCount++">


```


this will count how many keystroke for the text box.


------------------------------
This is keyup modifier 

```js
    <textarea v-on:keyup.s="createAlert"></textarea>
```
 This is checking if the user uses the "s" key on the text area and we can count how many times people use it.