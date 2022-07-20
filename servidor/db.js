const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const router = express.Router();
app.use(bodyParser.json());
app.use(cors());
app.use(express.json());



const MONGO_CNSTRING = 'mongodb+srv://davirsreis:davi123@cluster0.hcqi7le.mongodb.net/?retryWrites=true&w=majority';

const mongo = require('mongodb');
const MongoClient = mongo.MongoClient;
//const MongoClient = require('mongodb').MongoClient;
const ObjectID = mongo.ObjectID;

//const url = 'mongodb://localhost:27017'
const url = MONGO_CNSTRING

const dbName = 'flutter-db';
const client = new MongoClient(url);

function newUser(nome, email, endereco, senha){
    client.connect(async function (err) {
        console.log('Connected successfully to server');


        const db = client.db(dbName)
        const usuarios = db.collection('usuarios')
        console.log('enviando dados');
          await usuarios.insertOne({
             _id: new ObjectID(), nome: nome, email: email, endereco: endereco, senha: senha,
        })
    
        client.close()
    })
}


function userExists() {
    client.connect(async function (err) {
        console.log('Connected successfully to server');


        const db = client.db(dbName)
        const usuarios = db.collection('usuarios')
        console.log('enviando dados');

        if (err) throw err;
        db.collection("usuarios").find({}).toArray(function(err, result) {
            if (err) throw err;
            console.log(result);
            console.log(result[0].email);
            client.close()
        });
        
    
        
    })
}

userExists();




//Here we are configuring express to use body-parser as middle-ware.
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

router.post('/cadastro',(request,response) => {
//code to perform particular action.
//To access POST variable use req.body()methods.

    console.log(request.body);
    Nome = request.body.nome;
    Email = request.body.email;
    Endereco = request.body.endereco;
    Senha = request.body.senha;
    newUser(Nome,Email,Endereco,Senha);
});


// router.get('/usuarios',(request,response) => {
//     //code to perform particular action.
//     //To access GET variable use req.query() and req.params() methods.
//     });

// router.get('/usuarios',(request,response) => {
//     client.connect(async function (err) {
//         console.log('Connected successfully to server');


//         const db = client.db(dbName)
//         const usuarios = db.collection('usuarios');
//         console.log('enviando usuarios');
//         let users = [];
//         console.log();
        
//         client.close()
//     })
// });

// add router in the Express app.
app.use("/", router);

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
            valor: 99.99
        },
        {
            id: 6,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 7,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 7,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 8,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 9,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 10,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 11,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 12,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 13,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 14,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 15,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 16,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 17,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
        },
        {
            id: 18,
            nome: "",
            descricao: "Produto",
            foto: "",
            medidas: "?",
            valor: 0.0
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
