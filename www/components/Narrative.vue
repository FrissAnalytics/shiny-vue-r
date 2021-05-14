<template>
  <div class="panel">
    <div id="narrative-panel" class="mx-auto px-3 ma-3 narrative-wrapper">
      <p class="text-h3 text-center title">Narrative</p>

      <div class="narrative-content text-justify">
        <div class="my-2 pa-4">
          <div class="text-center orange--text">Introduction</div>

          <p>
            The storyline for this app is semi-serious. In early 2020 a movie
            scenario of a potentially deadly and highly infectious disease,
            quickly spreading all over the world, has become a reality. Many
            people are locked into their homes. As almost all social events are
            cancelled, watching movies at home is a helpful way of dealing with
            the pandemic and reducing stress.
          </p>

          <p>
            As a companion app for the movie-explorer app in the official Shiny
            example's gallery, we present a Shiny-Vue based movie explorer
            application in which you can search for information on tens of
            thousands of movies.
          </p>

          <p>
            You can see movie posters, read movie summaries and get detailed
            information on its cast.
          </p>

          <p>
            In addition, the app allows you to inspect the current covid
            situation all over the world, via an interactive globe component,
            coupled with a timeline and an interactive storyline component. For
            each date, the storyline provides an overview of the most important
            developments during that day.
          </p>

          <p>
            The movie data comes from The Movie Data Base (TMDB), which has an
            API that is free to use for non-commercial applications.
          </p>

          <p>
            The covid data comes from several sources and aggregation services,
            such as the John Hopkins University, as well as from the creators of
            AM-charts. Both are open source and free to use for non-commercial
            applications.
          </p>

          <div class="d-flex justify-center">
            <img src="./img/home.png" width="100%" />
          </div>

          <div class="text-center orange--text">
            Combining Shiny with Vue.js
          </div>
          <p>
            In this work we take different perspective in creating a Shiny app
            than seen in most Shiny apps.
          </p>

          <p>
            Instead of exploring and analyzing data, we explore the idea of
            creating a Shiny application using the Vue.js frontend framework. In
            this setup, only the server.R part of Shiny is used, while the ui
            part is completely taken over by Vue.
          </p>

          <p>
            In the classic approach, both the frontend (ui) and the backend
            (server) parts are completely written in R. R will then take your
            code and convert it into a frontend application, creating the
            required HTML (the page structure), the JavaScript (the
            interactions) and CSS (the styling) code for you, so the browser can
            execute it.
          </p>

          <p>
            In this work, ui.R only has a single line, a call to htmlTemplate.
            This will trigger a load to template.html, which subsequently
            initializes a Vue.js instance. From there on, all frontend
            activities are controlled by Vue, including all interactions with
            Shiny.
          </p>

          <p>
            So why deviate? In a two words: create freedom! This way you can do
            whatever you want in the frontend and are not restricted by what
            bootstrap can do. You can also leverage the power of composing your
            application via a set of interactive, data driven front-end
            components, which allow for interaction patterns that are difficult
            or cumbersome to do using more traditional server-side approaches.
          </p>

          <p>
            Shortly, in this work we showcase what you can do with Vue.js and
            how to couple its amazing powers to Shiny. Instead of Bootstrap we
            use a component-based framework called Vuetify, which combines the
            powers of Vue.js with the design philosophy of Material Design. Both
            Vue and Vuetify come with amazing documentation and many examples
            and code pens.
          </p>

          <div class="text-center orange--text">
            Different, not better per se.
          </div>
          <p>
            Please note that by no means we intend to suggest this way of
            creating apps is better. In most situations, taking the traditional
            Shiny route is absolutely the way to go. Likely it’s much easier,
            faster and already gives you what you need!
          </p>

          <p>
            Having said this, tools like Vuetify bring an unbelievable set of
            opportunities to Shiny and with it making modern designs is a
            breeze. Arguably one of the best parts of R are its ability to
            manipulate data and fit models via the tidyverse and to plot data
            via ggplot. In this work all that power is still there, but it is
            combined with the awesome abilities of modern reactive frontend
            frameworks such as Vue and Vuetify.
          </p>

          <p>
            The creative freedom gained by our approach does come at a price:
            more complexity. However, to a degree that depends what you use and
            your willingness to learn something new. Compared to other
            frameworks, Vue.js is easy to learn, has a simple and elegant syntax
            and requires little boilerplate code to setup. Oh, and Vue is the
            4th most popular project on Github to date with over 180 thousand
            stars!
          </p>

          <p>
            A lot of the power of Shiny comes from using tag functions, which
            let you make things like headers, divs, spans etc. To get the most
            out of tag functions, you do need to know a little bit on HTML and
            to style them or position them knowledge on CSS definitely comes in
            handy.
          </p>

          <p>
            Some tags seem to have more ‘power’ than others. For instance, an h1
            tag ‘just’ displays text bigger, but use a single video tag, give it
            a few attributes and ‘boom’, you got yourself a 4k video player with
            navigation controls to go, right in your browser!
          </p>

          <div class="d-flex justify-center my-5">
            <img src="./img/video.png" height="50px" />
          </div>

          <div class="text-center orange--text">Why pick Vue.js?</div>

          <p>
            So, what if you could create your own HTML tags and give them
            superpowers of your of choosing?
          </p>

          <p>
            That is what frameworks like Vue and React do for you. They allow
            you to make your own tags or import them from someone else and use
            them inside your markup code. As the name React suggests, these
            components are reactive and instantly respond to data changes or
            incoming messages, just like Shiny.
          </p>

          <p>
            Even though frontend frameworks like React and Angular work very
            well, they come with more complicated procedures and often require
            usage of complex build systems such as Webpack.
          </p>

          <p>
            Vue, however, is a blend between the design philosophies of React
            and Angular and is extremely popular too. According to many, Vue is
            much simpler to use though. It’s also incrementally adoptable, which
            means you can take the bits and pieces you like and stick them into
            an existing framework. In our case, that framework is Shiny!
          </p>

          <div class="text-center orange--text">Making your own components</div>
          <p>
            A system like Vue allows you to create your own components (custom
            html tags), that essentially do what you want, with arbitrarily
            complex behavior. Like Lego blocks, you then compose your
            application using the individual building blocks.
          </p>

          <div class="d-flex justify-center">
            <img src="./img/vue_lego.png" width="100%" />
          </div>

          <p>
            These components do not only generate complex HTML and styling, but
            also allow for all kinds of new interaction patterns as each
            component can have its own data, scope, methods and lifecycle hooks.
            They are also designed from the ground up to easily interact (react)
            with other components.
          </p>

          <p>
            As with the video element, components can also contain other
            components.
          </p>

          <div class="text-center orange--text">Composing with components</div>
          <p>
            It’s common for an app to be organized into a tree of nested
            components.
          </p>

          <div class="d-flex justify-center">
            <img src="./img/component_tree.png" width="100%" />
          </div>

          <p>
            In the example above you see a simple page, which represents
            component A. Component A is said to have 3 child components: B, C
            and D. Finally, C itself has 2 child components: E and F, while D
            has 3 child components: G,H and I.
          </p>

          <div class="text-center orange--text">Components can be anything</div>
          <p>
            A component is whatever you need it to be and can be as simple as a
            button, but it can also be a complete app (in which case it has many
            child components, that themselves have many child components as
            well).
          </p>

          <p>
            An example of a component could be a sliderInput component, like the
            one in Shiny. In Shiny, in ui.R you simply declare you want one and
            give it some parameters, like an input id e.g., slider1, a name, a
            label, some min and max values and a start value. Shiny will then
            render a slider for you and initializes its values. Actually,
            JavaScript is doing that for you, but normally you don’t care about
            that. Shiny nicely abstracts that part away from you.
          </p>

          <p>
            The slider reacts when you move it and passes this information from
            the frontend (the browser) to the backend (server.R) . In server.R
            you can then listen to data changes using
            observeEvent(input$slider1, { … }).
          </p>

          <p>
            The slider component also has state, it remembers which value you
            picked last! Also, it does the styling for you.
          </p>

          <div class="text-center orange--text">Single File Components</div>
          <p>
            Vue has a unique feature called Single File Components (SFC), in
            which in a single file you can define how a component is structured
            (HTML template), what data and interactive methods it has
            (JavaScript) and how it is styled (CSS). Like Shiny, data is
            reactive! It also comes with many (lifecycle) methods, data watchers
            and slots.
          </p>

          <p>
            The example component below will render a styled paragraph text with
            saying “Hello World!”. If the data updates, the component will
            re-render, just like Shiny.
          </p>

          <div class="d-flex justify-center">
            <img src="./img/vue-component.png" width="100%" />
          </div>

          <p>
            CSS can be scoped, which means the CSS rules you state are only
            applied to that component and nothing else, which is very handy as
            you can make small tweaks when you need it, without disrupting the
            styling of other elements. Shiny has various methods to update
            markup, but Vue.js in that sense is quite superior.
          </p>

          <div class="text-center orange--text">
            Components are a lot like Shiny modules
          </div>
          <p>
            Even though conceptually different, it’s helpful to think about a
            Vue component as a Shiny module. They both control a part of the
            data; they are both reactive and they are both responsible to render
            a part of the ui. In addition, modules and components can be reused
            and each instance has its own scope.
          </p>

          <div class="d-flex justify-center">
            <img src="./img/home.png" width="100%" />
          </div>

          <p>
            For example, in this app, the front page is a single component,
            called Home. Home itself has a search-box component and a component
            showing an interactive grid of movie posters, showing the most
            popular movies of the current day.
          </p>

          <div class="text-center orange--text">Upcoming tutorial series</div>

          <p>
            A complete tutorial on Vue and its helpers i.e., Vuex, Vue router
            etc. is beyond the scope of this contest, but a more complete set of
            in-depth tutorials is on its way and a link will appear in the code
            repo of this app.
          </p>

          <p>
            We realize without this tutorial series the content below is hard to
            follow. Please know a complete write-up will be there soon [mid
            June].
          </p>

          <p>
            We proceed by walking through the most import parts of the app and
            explain how Vue.js communicates with Shiny and how components
            communicate with each other, including the use of a state manager,
            called Vuex.
          </p>

          <div class="text-center orange--text">
            Main JavaScript libraries used
          </div>

          <div class="text-center my-5">
            <div>Vue</div>

            <div>Vue-router</div>

            <div>Vuex</div>

            <div>Vuetify</div>

            <div>Http-vue-loader</div>

            <div>Mitt.js</div>

            <div>lodash</div>

            <div>d3.js</div>

            <div>globe.gl</div>

            <div>material design & font-awesome icons</div>

            <div>OverlayScrollbars</div>
          </div>

          <div class="text-center orange--text">App overview</div>

          <p>This is the home page. Suppose we click on movie card 6:</p>

          <div class="d-flex justify-center">
            <img src="./img/home.png" width="100%" />
          </div>

          <p>
            Via the router this brings us to the MovieDetails.vue component. Say
            we then click on the card for Bob Odenkirk
          </p>

          <div class="d-flex justify-center">
            <img src="./img/movie_details.png" width="100%" />
          </div>

          <p>
            Via the router this brings us to the PersonDetails.vue component.
          </p>

          <p>
            If we need data, via an event bus we ask Shiny to get it. Next,
            Shiny which will send a custom message to update Vuex.
          </p>

          <div class="d-flex justify-center">
            <img src="./img/person_details.png" width="100%" />
          </div>

          <p>
            There is also an overview gallery showing information all movies
            that won the academy award for best picture.
          </p>

          <p>A click on a movie brings you to its Movie Details view.</p>

          <div class="d-flex justify-center">
            <img src="./img/oscars.png" width="100%" />
          </div>

          <p>
            In the last panel we see the Globe.Vue component, which shows covid
            statistic for the whole world, with an interactive globe (center),
            timeline (top), a storyline component and a set of controls (mid
            right, bottom).
          </p>

          <div class="d-flex justify-center">
            <img src="./img/globe.png" width="100%" />
          </div>

          <p>
            A click on the timeline will show the closest date for which we have
            a story.
          </p>

          <p>
            Story information was pulled from
            https://www.devex.com/news/covid-19-a-timeline-of-the-coronavirus-outbreak-96396
            using rvest and manually cleaned
          </p>

          <div class="text-center orange--text">
            Example of rendering ggplot output in a Vue component
          </div>

          <p>
            The orange button on the bottom control component in the globe panel
            will trigger a dialog (a modal), that shows a ggplot based panel
            allowing you to compare various covid stats over time and countries
          </p>

          <div class="d-flex justify-center">
            <img src="./img/covid_comparison.png" width="100%" />
          </div>

          <p>
            You can select multiple countries and compare timeseries data for
            counts on confirmed, deaths and recovered cases. You can also
            inspect the daily deltas or the overall counts.
          </p>

          <p>
            When clicking compare (orange button), Vue will call Shiny and ask
            for a computation to be done, computing the time series for your
            selection, for which it uses dplyr.
          </p>

          <p>
            After the computation is done, a ggplot graph is created by Shiny,
            that is picked up by Vue and shown in the modal.
          </p>

          <div class="text-center orange--text">Vuetify</div>

          <p>
            Most components in this app use Vuetify. Vuetify is a great choice
            as it has so many components, helper classes and options. Please see

            <a href="https://vuetifyjs.com/en/">vuetifyjs.com</a> for what is
            available. It’s really amazing what this team has created so far and
            it’s all open source.
          </p>

          <div class="d-flex justify-center">
            <img src="./img/vuetify_examples.png" height="350px" />
          </div>

          <div class="text-center orange--text">
            The Shiny Vue communication process
          </div>

          <p>Communication between Shiny and Vue happens in various ways:</p>

          <div class="d-flex justify-center my-5">
            <img src="./img/part1.png" width="100%" />
          </div>

          <div class="d-flex justify-center my-5">
            <img src="./img/part2.png" width="100%" />
          </div>

          <div class="d-flex justify-center my-5">
            <img src="./img/part3.png" width="100%" />
          </div>

          <div class="d-flex justify-center my-5">
            <img src="./img/part4.png" width="100%" />
          </div>

          <div class="d-flex justify-center my-5">
            <img src="./img/part5.png" width="100%" />
          </div>

          <div class="d-flex justify-center my-5">
            <img src="./img/part6.png" width="100%" />
          </div>

          <div class="d-flex justify-center my-5">
            <img src="./img/part7.png" width="100%" />
          </div>

          <div class="d-flex justify-center my-5">
            <img src="./img/part8.png" width="100%" />
          </div>

          <div class="text-center orange--text">Closing remarks</div>

          <p>
            In closing, we showed an extensive example on how to hook up Shiny
            and Vue in a way that you can use Singe File Components with scoped
            CSS. This can be done without a build step.
          </p>

          <p>
            Early experiments indicate we can also incorporate HTMLWidgets such
            as Leaflet and Plotly. However, more work is needed to make sure
            these type of plots behave as they should. The same goes for using
            brushes etc. on ggplot outputs. Please know the current app is not
            ready for this type of interaction, but a future update likely will
            be.
          </p>

          <p>
            Of course, instead of having a setup in which the frontend and
            backend are coupled, you can also choose to separate them
            completely. For instance, using Plumber or by having a Python based
            backend.
          </p>

          <p>
            In most cases that leads to a stateless backend, which is different
            from the in memory, stateful backend available via this setup.
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "narative",

  mounted() {
    const el = document.querySelector("#narrative-panel");

    const options = {
      className: "os-theme-round-light",
      scrollbars: { autoHide: "leave" },
    };

    this.scroller = OverlayScrollbars(el, options);
  },

  methods: {
    goto(id) {
      const target = "#ipsum" + id;

      this.$vuetify.goTo(target, { container: "#narrative-panel" });
    },
  },
};
</script>

<style scoped>
.title {
  color: #673ab7;
}

.panel {
  background-color: black;
  width: 100%;
  height: calc(100vh);
  padding-top: 48px;
}

#narrative-panel {
  height: 85vh;
  overflow: scroll;
}

.narrative-wrapper {
  width: 50vw;
  background-color: #202023;
}

.narrative-content {
  font-size: 1.2rem;
  line-height: 1.7rem;
}

.narrative-content p {
  padding: 4px 20px;
  margin: 15px;
  background-color: #242424;
  color: #c7c7c7;
}

.narrative-content img {
  padding: 4px 20px;
}
</style>