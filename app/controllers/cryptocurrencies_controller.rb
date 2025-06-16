class CryptocurrenciesController < ApplicationController
  def index
    @crypto_data = fetch_crypto_data_from_api
    @cryptos = RandomSelection.all  # Ensure that @cryptos is always assigned
  end

  def create
    json_data = params[:crypto_data]
    if json_data.blank?
      @error_message = "No se recibieron datos de criptomonedas."
      return render :index
    end

    crypto_data = JSON.parse(json_data)
    debugger
    crypto_key = crypto_data.keys.sample
    selected_data = crypto_data[crypto_key]
    @selected_crypto = RandomSelection.create!(name: crypto_key, price: selected_data["usd"])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cryptocurrency_path(@selected_crypto) }
    end
  end

  def show
    @selected_crypto = RandomSelection.last
  end

  def update
    @selected_crypto = RandomSelection.find(params[:id])
    
    if @selected_crypto.update(price: params[:random_selection][:price])
      respond_to do |format|
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(
            "crypto-#{@selected_crypto.id}",
            partial: "cryptocurrencies/crypto_row",
            locals: { crypto: @selected_crypto }
          )
        }
        format.html { redirect_to cryptocurrencies_path }
      end
    else
      flash.now[:alert] = "Error al actualizar el precio."
      render :show
    end
  end

  def low_to_high
    @cryptos = RandomSelection.order(price: :asc)
    render :index
  end

  def high_to_low
    @cryptos = RandomSelection.order(price: :desc)
    render :index
  end

  def search
    query = params[:query]&.strip&.downcase

    if query.blank?
      redirect_to cryptocurrencies_path, alert: "Ingresa un nombre de criptomoneda válido."
      return
    end

    url = "https://api.coingecko.com/api/v3/simple/price?ids=#{query}&vs_currencies=usd"

    begin
      response = HTTParty.get(url)

      if response.success? && response.parsed_response[query]
        price = response.parsed_response[query]["usd"]
        @searched_crypto = { name: query, price: price }
      else
        flash.now[:alert] = "No se encontró la criptomoneda '#{query}'."
      end
    rescue => e
      flash.now[:alert] = "Error al buscar: #{e.message}"
    end

    render :search_result
  end

  private

  def fetch_crypto_data_from_api
    url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,binancecoin,cardano,solana,xrp,polkadot,dogecoin,avalanche-2,shiba-inu,polygon,chainlink,litecoin,bitcoin-cash,uniswap,algorand,stellar,vechain,filecoin,tron,cosmos,ethereum-classic,monero,hedera-hashgraph,internet-computer,fantom,near,flow,decentraland,the-sandbox,axie-infinity,pancakeswap-token,theta-token,elrond-erd-2,klay-token,helium,zcash,dash,compound,maker,yearn-finance,sushiswap,1inch,curve-dao-token,aave,synthetix-network-token,uma,balancer,kyber-network-crystal,0x,ren,bancor,loopring,storj,basic-attention-token,enjincoin,chiliz,fet,ocean-protocol,numeraire,the-graph,livepeer,audius,ankr,request-network,civic,district0x,status,power-ledger,metal,waltonchain,wax,holo,iostoken,zilliqa,ontology,qtum,icon,lisk,nano,waves,komodo,ark,stratis,neblio,particl,nuls,pivx,syscoin,vertcoin,digibyte,ravencoin,horizen,beam,grin,handshake,nervos-network,harmony,tomochain,wan,iotex,thunder-token,celer-network,orion-protocol,injective-protocol,origin-protocol,nucypher,keep-network,skale,cartesi&vs_currencies=usd"

    response = HTTParty.get(url)
    
    # Verifica si la respuesta es exitosa
    if response.success?
      response.parsed_response
    else
      {}
    end
  end
end
