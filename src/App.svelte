<script>
  import Router from "svelte-spa-router";
  import List from "./pages/List.svelte";
  import Home from "./pages/Home.svelte";
  import Signup from "./pages/Signup.svelte";

  const routes = {
    "/": Home,
    "/users/signup": Signup,
    "/users/list": List,
  };
</script>

<Router {routes} />
