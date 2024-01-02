<script>
  import { Router, Link, Route } from "svelte-routing";
  import List from "./pages/List.svelte";
  import Home from "./pages/Home.svelte";
  import Signup from "./pages/Signup.svelte";

  export let url = "";
</script>

<Router {url}>
  <Route path="/"><Home /></Route>
  <Route path="/users/signup" component={Signup}>회원 가입</Route>
  <Route path="/users/list" component={List}>회원 목록</Route>
</Router>
