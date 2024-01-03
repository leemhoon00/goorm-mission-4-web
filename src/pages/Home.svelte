<script>
  import { Router, Link, Route } from "svelte-routing";
  import List from "./List.svelte";
</script>

<header>
  <h1>Hello Nest1</h1>
</header>
<main>
  <div>
    <h2>회원 기능</h2>
    <a href="/users/signup">회원 가입</a>
    <a href="/users/list">회원 목록</a>
  </div>
</main>

<style>
  header {
    text-align: center;
    padding: 1em 0;
  }
  main {
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  h1,
  h2 {
    color: #333;
  }
  a {
    text-decoration: none;
    color: #007bff;
    margin-right: 20px;
  }
  a:hover {
    text-decoration: underline;
  }
</style>
