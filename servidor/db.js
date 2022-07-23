const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const router = express.Router();
app.use(bodyParser.json());
app.use(cors());
app.use(express.json());
const { promisify } = require('util')
const sleep = promisify(setTimeout)



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
var isAuth = false;
function userExists(email, senha) {
    client.connect(async function (err) {
        console.log('Connected successfully to server');

        const db = client.db(dbName)
        const usuarios = db.collection('usuarios')
        console.log('Email informado: ', email,'Senha informada:', senha);

        if (err) throw err;
        db.collection("usuarios").find({ email: email, senha: senha }).toArray(function(err, result) {   
            if (err) throw err;

            client.close();

    if(result.length == 1){
        console.log('login autorizado!');
        return isAuth = true;
    } else { 
        console.log('login não autorizado!');
        return isAuth = false;
    };
            
        });
    })
}



router.post('/login',(request,response) => {
    //code to perform particular action.
    //To access POST variable use req.body()methods.
    
        //console.log(request.body);
        Email = request.body.email;
        Senha = request.body.senha;
        userExists(Email, Senha);
        sleep(1000).then(() => {
            if(isAuth==true){
                response.statusCode=200;
                console.log('isAuth true');
            } else {
                response.statusCode=404;
                console.log('isAuth false');
            }
          })

        //return response.statusCode=404;

        
            // if(isAuth==1){
        //     response.statusCode = 200;
        // } else {
        //     response.statusCode = 404;
        // }
        //console.log(response.header);
});




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

router.post('/addCarrinho',(request,response) => {
    //code to perform particular action.
    //To access POST variable use req.body()methods.
    
        console.log(request.body);
        Descricao = request.body.descricao;
        Valor = request.body.valor;
        String(Valor);
        newCompra(Descricao, Valor);
});

function newCompra(descricao, valor){
    client.connect(async function (err) {
        console.log('Connected successfully to server');


        const db = client.db(dbName)
        const carrinho = db.collection('carrinho')
        console.log('adicionando ao carrinho');
          await carrinho.insertOne({
             _id: new ObjectID(), descricao: descricao, valor: valor,
        })
    
        client.close()
    })
}

router.post('/delItem',(request,response) => {
    //code to perform particular action.
    //To access POST variable use req.body()methods.
    
        console.log(request.body);
        Descricao = request.body.descricao;
        delCompra(Descricao);
});

function delCompra(descricao, valor){
    client.connect(async function (err) {
        console.log('Connected successfully to server');


        const db = client.db(dbName)
        const carrinho = db.collection('carrinho')
        console.log('adicionando ao carrinho');
          await carrinho.deleteOne({
             descricao: descricao,
        })
    
        client.close()
    })
}


// add router in the Express app.
app.use("/", router);

app.get('/',(req,res)=>{
    client.connect(async function (err) {
        console.log('Connected successfully to server');

        const db = client.db(dbName)
        const usuarios = db.collection('usuarios')

        if (err) throw err;
        db.collection("produto").find({  }).toArray(function(err, result) {   
        if (err) throw err;
        client.close()
        return res.json(
            result
        )
        });
    })
   
})

app.get('/carrinho',(req,res)=>{
    client.connect(async function (err) {
        console.log('Connected successfully to server');

        const db = client.db(dbName)
        const carrinho = db.collection('carrinho')

        if (err) throw err;
        db.collection("carrinho").find({  }).toArray(function(err, result) {   
        if (err) throw err;
        client.close()
        return res.json(
            result
        )
        });
    })
   
})

app.get('/usuarios',(req,res)=>{
    client.connect(async function (err) {
        console.log('Connected successfully to server');

        const db = client.db(dbName)
        const usuarios = db.collection('usuarios')

        if (err) throw err;
        db.collection("usuarios").find({  }).toArray(function(err, result) {   
        if (err) throw err;
        client.close()
        //console.log(result)
        return res.json(
            result
        )
        });
    })
   
})

app.listen(
    8080,
    function () {
        console.log('Inicialização OK')
    }
);
