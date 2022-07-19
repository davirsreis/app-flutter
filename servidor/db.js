const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const router = express.Router();
app.use(bodyParser.json());
app.use(cors());
app.use(express.json())



const MONGO_CNSTRING = 'mongodb+srv://davirsreis:davi123@cluster0.hcqi7le.mongodb.net/?retryWrites=true&w=majority';

const mongo = require('mongodb');
const MongoClient = mongo.MongoClient;
//const MongoClient = require('mongodb').MongoClient;
const ObjectID = mongo.ObjectID;

//const url = 'mongodb://localhost:27017'
const url = MONGO_CNSTRING

const dbName = 'flutter-db';
const client = new MongoClient(url);

function newUser(nome, email, senha){
    client.connect(async function (err) {
        console.log('Connected successfully to server');


        const db = client.db(dbName)
        const usuarios = db.collection('usuarios')
        console.log('enviando dados');
          await usuarios.insertOne({
             _id: new ObjectID(), nome: nome, email: email, senha: senha,
        })
    
        client.close()
    })
}




//Here we are configuring express to use body-parser as middle-ware.
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

router.post('/cadastro',(request,response) => {
//code to perform particular action.
//To access POST variable use req.body()methods.

    console.log(request.body);
    Nome = request.body.nome;
    Email = request.body.email;
    Senha = request.body.senha;
    newUser(Nome,Email,Senha);
});

// add router in the Express app.
app.use("/", router);



// app.post(
//         '/cadastro',
//      function(req,res){
//          res.send(
//             console.log(`teste`),
            
//         )
        
//      }
//  )

// const pg = require('pg');

// const client = new pg.Client(
//     {
//         user: 'postgres',
//         host: 'localhost',
//         database: 'flutter-aplication',
//         password: 'davi123',
//         port: 5432
//     }
// )

// client.connect();

// async function selectCustomers() {
//     //const client = await connect();
//     const res = await client.query('SELECT * FROM usuarios');
//     console.log(res.rows);
//     return res.rows;

// }

// async function insertCustomer(customer){
//     //const client = await connect();
//     const sql = 'INSERT INTO usuarios(nome,email,senha) VALUES ($1,$2,$3);';
//     const values = [customer.nome, customer.email, customer.senha];
//     return await client.query(sql, values);
// }

// function cadastrarUsuario(nome,email,senha){
//     (async () => {
//         //const db = require("./db");
//         console.log('Começou!');
        
//         console.log('INSERT INTO usuarios');
//         const result = await insertCustomer({nome: nome, email: email, senha: senha});
//         console.log(result.rowCount);
    
//     })();
// }

//cadastrarUsuario('teste','teste@gmail.com','12345');

app.get('/',(req,res)=>{
    return res.json(
    [
        {
            id: 1,
            nome: "Camiseta",
            descricao: "StarWars (Darth Vader) - Preta Estampada",
            foto: "https://i0.wp.com/cf.shopee.com.br/file/648f35203f521789bc3ac4a9609349b1?&ssl=1",
            medidas: "M",
            valor: 34.99
        },
        {
            id: 2,
            nome: "Camiseta",
            descricao: "StarWars - Preta com Amarelo",
            foto: "https://i0.wp.com/www.veinerd.com/uploads/products/large/starwars-1.jpg?&ssl=1",
            medidas: "M",
            valor: 39.99
        },
        {
            id: 3,
            nome: "Camiseta",
            descricao: "Stranger Things - Preta Estampada",
            foto: "https://i0.wp.com/img.elo7.com.br/product/zoom/275DB1A/camiseta-stranger-things-3-temporada-estampa-total-serie.jpg?&ssl=1",
            medidas: "M",
            valor: 44.99
        },
        {
            id: 4,
            nome: "Calça",
            descricao: "Moletom - Cinza",
            foto: "https://i0.wp.com/static.netshoes.com.br/produtos/calca-moletom-dead-love-masculina/10/JBB-0409-010/JBB-0409-010_zoom1.jpg?ts=1580900397?&ssl=1",
            medidas: "M",
            valor: 99.99
        },
        {
            id: 5,
            nome: "Calça",
            descricao: "Moletom - Preta",
            foto: "https://i0.wp.com/static.dafiti.com.br/p/Benellys-Cal%C3%A7a-Moletom-Flanelado-Masculino-Benellys-Lisa-Preto-7109-7001398-1-zoom.jpg?&ssl=1",
            medidas: "M",
            valor: 109.99
        },
    ]
    )
})

// let itensCount = 0;
// let itensId = [];
// app.post(
//     '/comprar',
//     function(req,res){
//         itensCount++,
//         res.send(
//             console.log(`Itens no carrinho: ${itensCount}`)
//             )
        
//     }
// )

// app.get(
//     '/comprar',
//     function(req,res){
//         res.send(`<h1>Itens no carrinho: <span>${itensCount}</span></h1>`)
//     }
// )

app.listen(
    8080,
    function () {
        console.log('Inicialização OK')
    }
);
