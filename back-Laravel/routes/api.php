<?php

use App\Http\Controllers\ProductController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
//Rota que cadastra um produto
Route::post('/produto/cadastro', [ProductController::class, 'createProduct']);

//Rota que lista um produto pelo id
Route::get('/produto/{id}', [ProductController::class, 'getProduct']);

//Rota que lista todos os produtos
Route::get('/produtos', [ProductController::class, 'getAllProducts']);

//Rota que apaga um produto pelo id
Route::delete('/produto/{id}', [ProductController::class, 'deleteProduct']);

//Rota que edita um produto
Route::put('/produto/{id}', [ProductController::class, 'updateProduto']);

//Rota que filtra produtos por categoria
Route::get('/produtos/{category}', [ProductController::class, 'getProductsByCategory']);


