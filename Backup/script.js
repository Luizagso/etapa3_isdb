document.addEventListener('DOMContentLoaded', function () {
    // Funções para buscar e exibir os dados

    function fetchPessoas() {
        fetch('fetch_pessoas.php')
            .then(response => response.json())
            .then(data => {
                const tabelaPessoas = document.getElementById('tabela-pessoas');
                tabelaPessoas.innerHTML = '';
                data.forEach(pessoa => {
                    tabelaPessoas.innerHTML += `
                        <tr>
                            <td>${pessoa.idPessoa}</td>
                            <td>${pessoa.nome}</td>
                            <td>${pessoa.CPF}</td>
                            <td>${pessoa.tipo}</td>
                            <td><button onclick="editarPessoa(${pessoa.idPessoa})">Editar</button></td>
                            <td><button onclick="excluirPessoa(${pessoa.idPessoa})">Excluir</button></td>
                        </tr>
                    `;
                });
            });
    }

    function fetchAnimais() {
        fetch('fetch_animals.php')
            .then(response => response.json())
            .then(data => {
                const tabelaAnimais = document.getElementById('tabela-animais');
                tabelaAnimais.innerHTML = '';
                data.forEach(animal => {
                    tabelaAnimais.innerHTML += `
                        <tr>
                            <td>${animal.idAnimal}</td>
                            <td>${animal.nome}</td>
                            <td>${animal.registro}</td>
                            <td>${animal.especie}</td>
                            <td><button onclick="editarAnimal(${animal.idAnimal})">Editar</button></td>
                            <td><button onclick="excluirAnimal(${animal.idAnimal})">Excluir</button></td>
                        </tr>
                    `;
                });
            });
    }

    function fetchConsultas() {
        fetch('fetch_consultas.php')
            .then(response => response.json())
            .then(data => {
                const tabelaConsultas = document.getElementById('tabela-consultas');
                tabelaConsultas.innerHTML = '';
                data.forEach(consulta => {
                    tabelaConsultas.innerHTML += `
                        <tr>
                            <td>${consulta.idConsulta}</td>
                            <td>${consulta.dataConsulta}</td>
                            <td>${consulta.idAnimal}</td>
                            <td>${consulta.idPessoa}</td>
                            <td><button onclick="editarConsulta(${consulta.idConsulta})">Editar</button></td>
                            <td><button onclick="excluirConsulta(${consulta.idConsulta})">Excluir</button></td>
                        </tr>
                    `;
                });
            });
    }

    // Funções para edição
    function editarPessoa(idPessoa) {
        const nome = prompt("Novo nome:");
        const cpf = prompt("Novo CPF:");
        const tipo = prompt("Novo tipo (Veterinario/Tutor):");

        const formData = new FormData();
        formData.append('idPessoa', idPessoa);
        formData.append('nome', nome);
        formData.append('cpf', cpf);
        formData.append('tipo', tipo);

        fetch('update.php', {
            method: 'POST',
            body: formData
        }).then(response => response.text())
          .then(data => {
              alert(data);  // Mostra mensagem de confirmação
              fetchPessoas();  // Atualiza a lista de pessoas
          });
    }

    function editarAnimal(idAnimal) {
        const nome = prompt("Novo nome:");
        const registro = prompt("Novo registro:");
        const idPessoa = prompt("Novo idPessoa:");
        const dataNasc = prompt("Nova data de nascimento:");
        const raca = prompt("Nova raça:");
        const especie = prompt("Nova espécie:");
        const sexo = prompt("Novo sexo (Masculino/Feminino):");

        const formData = new FormData();
        formData.append('idAnimal', idAnimal);
        formData.append('nome', nome);
        formData.append('registro', registro);
        formData.append('idPessoa', idPessoa);
        formData.append('dataNasc', dataNasc);
        formData.append('raca', raca);
        formData.append('especie', especie);
        formData.append('sexo', sexo);

        fetch('update.php', {
            method: 'POST',
            body: formData
        }).then(response => response.text())
          .then(data => {
              alert(data);  // Mostra mensagem de confirmação
              fetchAnimais();  // Atualiza a lista de animais
          });
    }

    function editarConsulta(idConsulta) {
        const dataConsulta = prompt("Nova data da consulta:");
        const idAnimal = prompt("Novo idAnimal:");
        const idPessoa = prompt("Novo idPessoa:");
        const dataLimiteRetorno = prompt("Nova data limite de retorno:");

        const formData = new FormData();
        formData.append('idConsulta', idConsulta);
        formData.append('dataConsulta', dataConsulta);
        formData.append('idAnimal', idAnimal);
        formData.append('idPessoa', idPessoa);
        formData.append('dataLimiteRetorno', dataLimiteRetorno);

        fetch('update.php', {
            method: 'POST',
            body: formData
        }).then(response => response.text())
          .then(data => {
              alert(data);  // Mostra mensagem de confirmação
              fetchConsultas();  // Atualiza a lista de consultas
          });
    }

    // Funções para exclusão
    function excluirPessoa(idPessoa) {
        if (confirm("Tem certeza que deseja excluir este registro?")) {
            const formData = new FormData();
            formData.append('idPessoa', idPessoa);

            fetch('delete.php', {
                method: 'POST',
                body: formData
            }).then(response => response.text())
              .then(data => {
                  alert(data);  // Mostra mensagem de confirmação
                  fetchPessoas();  // Atualiza a lista de pessoas
              });
        }
    }

    function excluirAnimal(idAnimal) {
        if (confirm("Tem certeza que deseja excluir este registro?")) {
            const formData = new FormData();
            formData.append('idAnimal', idAnimal);

            fetch('delete.php', {
                method: 'POST',
                body: formData
            }).then(response => response.text())
              .then(data => {
                  alert(data);  // Mostra mensagem de confirmação
                  fetchAnimais();  // Atualiza a lista de animais
              });
        }
    }

    function excluirConsulta(idConsulta) {
        if (confirm("Tem certeza que deseja excluir este registro?")) {
            const formData = new FormData();
            formData.append('idConsulta', idConsulta);

            fetch('delete.php', {
                method: 'POST',
                body: formData
            }).then(response => response.text())
              .then(data => {
                  alert(data);  // Mostra mensagem de confirmação
                  fetchConsultas();  // Atualiza a lista de consultas
              });
        }
    }

    // Função para alternar entre as abas
    function openTab(tabName) {
        const tabs = document.getElementsByClassName('tab');
        for (let i = 0; i < tabs.length; i++) {
            tabs[i].style.display = 'none';
        }
        document.getElementById(tabName).style.display = 'block';
    }

    // Inicializa com a aba de visualização aberta
    openTab('visualizar');

    // Adicionar eventos para os botões de menu
    document.getElementById('menu-inserir-pessoa').addEventListener('click', function() {
        openTab('inserir-pessoa');
    });

    document.getElementById('menu-inserir-animal').addEventListener('click', function() {
        openTab('inserir-animal');
    });

    document.getElementById('menu-inserir-consulta').addEventListener('click', function() {
        openTab('inserir-consulta');
    });

    document.getElementById('menu-visualizar').addEventListener('click', function() {
        openTab('visualizar');
        fetchPessoas();
        fetchAnimais();
        fetchConsultas();
    });

    // Carregar os dados ao iniciar
    fetchPessoas();
    fetchAnimais();
    fetchConsultas();

    // Expor funções de edição e exclusão para o escopo global
    window.editarPessoa = editarPessoa;
    window.editarAnimal = editarAnimal;
    window.editarConsulta = editarConsulta;
    window.excluirPessoa = excluirPessoa;
    window.excluirAnimal = excluirAnimal;
    window.excluirConsulta = excluirConsulta;
});