class PicturesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :is_admin?, only: [:new, :create, :edit, :update, :destroy]

  def index
    # Méthode qui récupère tous les photos et les envoie à la view index (index.html.erb) pour affichage
    @pictures = Picture.all
    puts "$" * 60
    puts "Voici le nombre die photos dans la base : #{@pictures.length}"
    puts "$" * 60
  end

  def show
    # Méthode qui récupère la photo concernée et l'envoie à la view show (show.html.erb) pour affichage
    @picture_hash = get_picture_hash 
  end

  def new
    # Méthode qui crée une photo vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    @new_picture = Picture.new
  end

  def create
    # Méthode qui créé une photo à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur "admin"
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher la photo créée)
    puts "$" * 60
    puts "Salut, je suis dans le serveur pour une création"
    puts "Ceci est le contenu du hash params : #{params}"
    puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ title : #{params["title"]}"
    @picture = Picture.new("title" => params[:title],
                           "description" => params[:description],
                           "price" => params[:price],
                           "img_url" => params[:img_url])
    if @picture.save # essaie de sauvegarder en base @picture
      # si ça marche, il redirige vers la page d'index du site
      redirect_to pictures_path, status: :ok, notice: 'Ta superbe photo de chaton(s) a bien été créée en base pour la postérité !'
    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      render 'new'
    end
    puts "$" * 60
  end

  def edit
    # Méthode qui récupère la photo concernée et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @picture_hash = get_picture_hash 
  end

  def update
    # Méthode qui met à jour la photo à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur "admin"
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher la photo modifiée)
    puts "$" * 60
    puts "Salut, je suis dans le serveur pour une mise à jour"
    puts "Ceci est le contenu du hash params : #{params}"
    puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ title : #{params["title"]}"
    ok = false
    @picture = Picture.find(params[:id])
    @picture_hash = { "picture" => @picture, "index" => params[:id] }
    puts "picture_hash : #{@picture_hash}"
    if !params[:title].nil? && !params[:price].nil? && !params[:img_url].nil?
      picture_saved = @picture.update("title" => params[:title], # essaie de sauvegarder en base @picture
                                      "description" => params[:description],
                                      "price" => params[:price],
                                      "img_url" => params[:img_url])
      if picture_saved
        # si ça a marché, il redirige vers la méthode index
        ok = true
        @picture = Picture.find(params[:id])
        @picture_hash = { "picture" => @picture, "index" => params[:id] }
        puts "picture_hash : #{@picture_hash}"
        redirect_to pictures_path, status: :ok, notice: 'Ta superbe photo de chaton(s) a bien été mise à jour en base : elle est bien plus "attractive" désormais !'
      end
    end
    if !ok
      # sinon, il render la view edit (qui est celle sur laquelle on est déjà)
      render 'edit'
    end
    puts "$" * 60
  end

  def destroy
    # Méthode qui récupère la photo concernée et la détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
    puts "$" * 60
    puts "Salut, je suis dans le serveur pour une suppression"
    puts "Ceci est le contenu du hash params : #{params}"
    puts "picture_id : #{params[:id]}"
    @picture_hash = get_picture_hash 
    if !@picture_hash['picture'].nil?
      @picture_hash['picture'].destroy
      redirect_to pictures_path, status: :ok, notice: 'Ta photo "ratée" a bien été supprimée en base : plus personne ne saura que tu as un jour osé la proposer !'
    end
    puts "$" * 60
  end

  private

  def get_picture_hash
    @picture_hash = { "picture" => nil, "index" => -1 }
    picture_id = params[:id].to_i
    picture = nil
    puts "$" * 60
    puts "picture_id : #{picture_id}"
    nb_total = Picture.last.id
    if picture_id.between?(1, nb_total)
      picture = Picture.find_by(id: picture_id)
    end
    @picture_hash = { "picture" => picture, "index" => picture_id }
    puts "picture_hash : #{@picture_hash}"
    puts "$" * 60
    @picture_hash
  end

  def is_admin?
    picture_id = params[:id].to_i
    picture = nil
    puts "$" * 60
    puts "picture_id : #{picture_id}"
    nb_total = Picture.last.id
    if picture_id.between?(1, nb_total)
      picture = Picture.find_by(id: picture_id)
    end
    unless !picture.nil? && admin?
      redirect_to pictures_path, notice: "Vous n'êtes pas l'administrateur du site!"
    end
    puts "$" * 60
  end
end
