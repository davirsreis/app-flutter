const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(cors());
app.use(express.json())

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

app.get(
    '/comprar',
    function(req,res){
        res.send('<h1>Compras realizadas:</h1>')
    }
)

app.post(
    '/comprar',
    function(req,res){
        res.send(console.log('deu certo'))
        
    }
)

app.listen(
    8080,
    function () {
        console.log('Inicialização OK')
    }
);
