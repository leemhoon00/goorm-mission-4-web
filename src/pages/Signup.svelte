<script>
  import { navigate } from "svelte-routing";
  const API_URL = import.meta.env.VITE_API_URL;

  let name = "";

  async function buttonClick() {
    const response = await fetch(`${API_URL}/users/`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ name }),
    });
    if (response.ok) {
      alert("회원가입 성공");
      navigate("/");
    } else {
      alert("회원가입 실패");
    }
  }
</script>

<main>
  <form on:submit|preventDefault>
    <div>
      <label for="name">이름</label>
      <input id="name" name="name" bind:value={name} type="text" />
    </div>
    <button id="submitButton" type="button" on:click={buttonClick}>등록</button>
  </form>
</main>

<style>
  main {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 80vh;
  }
  form {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
  }
  div {
    margin-bottom: 20px;
  }
  label {
    display: block;
    margin-bottom: 8px;
    color: #333;
  }
  input {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
  }
  button {
    background-color: #007bff;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  button:hover {
    background-color: #0056b3;
  }
</style>
