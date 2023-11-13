<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function createProduct(Request $request) //método para cadastrar produto ao banco
    {
        $product = new Product($request->all());
        if ($product->save() === true) {
            return response()->json($product);
        }
        return response()->json([
            "error" => "Erro ao cadastrar"
        ], 400);
    }

    public function getProduct(int $id) //método que mostra um produto específico do banco
    {
        $product = Product::find($id);
        return response()->json($product);
    }

    public function getAllProducts() //método que mostra todos os produtos do banco
    {
        $products = Product::all();;
        return response()->json($products);
    }

    public function deleteProduct($id) //m´todo que remove um produto do banco
    {
        $product = Product::findOrFail($id);

        if (!$product->exists()) {
            return response()->json(["error" => "Produto não encontrado"], 404);
        }

        $product->delete();

        return response()->json(["success" => "Produto removido com sucesso!"]);
    }

    public function update(int $id, Request $request) //método que edita um produto cadastrado no banco
    {
        // Conceito do PUT em Rest, é subistituir
        $product = Product::findOrFail($id);

        // Estamos preenchendo o que veio da request
        // no produtos que selecionamos pelo ID
        $product->fill($request->all());

        if ($product->save()) {
            return response()->json($product, 202);
        }
        return response('Erro ao atualizar', 400);
    }

    
}
