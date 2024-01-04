<script>
  const API_URL = import.meta.env.VITE_API_URL;
  const users = fetch(`${API_URL}/users/`).then((res) => res.json());
</script>

<h1>이름</h1>
<div class="list-container">
  <ul>
    {#await users}
      <li>로딩중...</li>
    {:then users}
      {#each users as user}
        <li>{user.id} - {user.name}</li>
      {/each}
    {:catch error}
      <li>에러 발생</li>
    {/await}
  </ul>
</div>

<style>
  h1 {
    color: #333;
  }

  .list-container {
    max-width: 400px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
  }

  ul {
    list-style-type: none;
    padding: 0;
    text-align: left;
  }

  li {
    margin: 10px 0;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }
</style>
